#include "sqlite3.h"

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

const sqlite3_module systblTablesModule;
const sqlite3_module systblColumnsModule;
const sqlite3_module systblKeysModule;
const sqlite3_module systblFieldsModule;
const sqlite3_module systblConstraintsModule;
const sqlite3_module systblTblSizeModule;
const sqlite3_module systblSPsModule;
const sqlite3_module systblUsersModule;
const sqlite3_module systblQueuesModule;
const sqlite3_module systblTablePermissionsModule;
const sqlite3_module systblTriggersModule;
const sqlite3_module systblKeywordsModule;
const sqlite3_module systblLimitsModule;
const sqlite3_module systblTunablesModule;
const sqlite3_module systblThreadPoolsModule;
const sqlite3_module systblPluginsModule;
const sqlite3_module systblAppsockHandlersModule;
const sqlite3_module systblOpcodeHandlersModule;
const sqlite3_module completionModule; // in ext/misc
const sqlite3_module systblClientStatsModule;
const sqlite3_module systblTimepartModule;
const sqlite3_module systblTimepartShardsModule;
const sqlite3_module systblTimepartEventsModule;
const sqlite3_module systblTransactionLogsModule;
const sqlite3_module systblMetricsModule;
const sqlite3_module systblTimeseriesModule;
const sqlite3_module systblReplStatsModule;
const sqlite3_module systblActivelocksModule;
const sqlite3_module systblLogicalOpsModule;
const sqlite3_module systblSystabsModule;

int systblTypeSamplesInit(sqlite3 *db);
int systblRepNetQueueStatInit(sqlite3 *db);
int systblSqlpoolQueueInit(sqlite3 *db);
int systblActivelocksInit(sqlite3 *db);
int systblNetUserfuncsInit(sqlite3 *db);
int systblClusterInit(sqlite3 *db);

int systblNextAllowedTable(sqlite3_int64 *tabId);

/* Simple yes/no answer for booleans */
#define YESNO(x) ((x) ? "Y" : "N")

#ifdef __cplusplus
} /* extern "C" */
#endif /* __cplusplus */
