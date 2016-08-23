select name
	,SUSER_SNAME(owner_sid) as DatabaseOwner
	,user_access_desc
	,state_desc
	,is_auto_close_on
	,is_auto_shrink_on
	,recovery_model_desc,
	log_reuse_wait_desc
	,page_verify_option_desc
from sys.databases

