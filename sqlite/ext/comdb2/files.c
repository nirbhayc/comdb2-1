/*
   Copyright 2021 Bloomberg Finance L.P.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
 */
#if (!defined(SQLITE_CORE) || defined(SQLITE_BUILDING_FOR_COMDB2)) &&          \
    !defined(SQLITE_OMIT_VIRTUALTABLE)

#if defined(SQLITE_BUILDING_FOR_COMDB2) && !defined(SQLITE_CORE)
#define SQLITE_CORE 1
#endif

#include <fcntl.h>
#include <stddef.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <comdb2systblInt.h>
#include <ezsystables.h>
#include <bb_oscompat.h>
#include <comdb2.h>

extern struct dbenv *thedb;

sqlite3_module systblFilesModule = {
    .access_flag = CDB2_ALLOW_USER,
    .systable_lock = "comdb2_files",
};

typedef struct file_entry {
    char *file; /* Name of the file */
    char *dir;  /* Name of the directory */
    systable_blobtype content;
} file_entry_t;

static void release_files(void *data, int npoints)
{
    file_entry_t *files = data;
    for (int i = 0; i < npoints; ++i) {
        free(files[i].file);
        free(files[i].dir);
        free(files[i].content.value);
    }
    free(files);
}

static int read_file(const char *path, void **buffer, size_t *sz)
{
    struct stat st;
    int fd;
    int rc;

    rc = stat(path, &st);
    if (rc == -1) {
        logmsg(LOGMSG_ERROR, "%s:%d can't stat %s (%s)\n", __func__, __LINE__,
               path, strerror(errno));
        return -1;
    }

    fd = open(path, O_RDONLY);
    if (fd == -1) {
        logmsg(LOGMSG_ERROR, "%s:%d %s\n", __func__, __LINE__, strerror(errno));
        return -1;
    }

    *buffer = malloc(st.st_size);
    if (*buffer == NULL) {
        logmsg(LOGMSG_ERROR, "%s:%d out-of-memory\n", __func__, __LINE__);
        goto err;
    }

    rc = read(fd, *buffer, st.st_size);
    if (rc == -1) {
        logmsg(LOGMSG_ERROR, "%s:%d %s\n", __func__, __LINE__, strerror(errno));
        goto err;
    }
    *sz = st.st_size;
    return 0;

err:
    free(*buffer);
    close(fd);
    return -1;
}

static int read_dir(const char *dirname, file_entry_t **files, int *count)
{
    struct dirent buf;
    struct dirent *de;
    int rc = 0;

    DIR *d = opendir(dirname);
    if (!d) {
        logmsg(LOGMSG_ERROR, "failed to read data directory\n");
        return -1;
    }

    while (bb_readdir(d, &buf, &de) == 0 && de) {
        if ((strcmp(de->d_name, ".") == 0) || (strcmp(de->d_name, "..") == 0)) {
            continue;
        }

        if (de->d_type == DT_DIR) {
            char dir[4096];
            snprintf(dir, sizeof(dir), "%s/%s", dirname, de->d_name);
            rc = read_dir(dir, files, count);
            if (rc != 0) {
                break;
            }
        } else {
            file_entry_t *files_tmp =
                realloc(*files, sizeof(file_entry_t) * (++(*count)));
            if (!files_tmp) {
                logmsg(LOGMSG_ERROR, "%s:%d: out-of-memory\n", __FILE__,
                       __LINE__);
                rc = -1;
                break;
            }
            *files = files_tmp;
            file_entry_t *f = (*files) + (*count) - 1;
            f->file = strdup(de->d_name);
            /* Remove the data directory prefix */
            if (strcmp(dirname, thedb->basedir) == 0) {
                f->dir = strdup("");
            } else {
                f->dir = strdup(dirname + strlen(thedb->basedir) + 1);
            }

            char path[4096];
            snprintf(path, sizeof(path), "%s/%s", dirname, f->file);
            rc = read_file(path, &f->content.value, &f->content.size);
            if (rc == -1) {
                break;
            }
        }
    }

    closedir(d);

    return rc;
}

static int get_files(void **data, int *npoints)
{
    file_entry_t *files = NULL;
    int count = 0;

    int rc = read_dir(thedb->basedir, &files, &count);
    if (rc != 0) {
        *npoints = -1;
        return rc;
    }

    *data = files;
    *npoints = count;
    return 0;
}

int systblFilesInit(sqlite3 *db)
{
    /* clang-format off */
    return create_system_table(
        db, "comdb2_files", &systblFilesModule,
        get_files, release_files, sizeof(file_entry_t),
        CDB2_CSTRING, "file", -1, offsetof(file_entry_t, file),
        CDB2_CSTRING, "dir", -1, offsetof(file_entry_t, dir),
        CDB2_BLOB, "content", -1, offsetof(file_entry_t, content),
        SYSTABLE_END_OF_FIELDS);
    /* clang-format on */
}
#endif /* (!defined(SQLITE_CORE) || defined(SQLITE_BUILDING_FOR_COMDB2))       \
          && !defined(SQLITE_OMIT_VIRTUALTABLE) */
