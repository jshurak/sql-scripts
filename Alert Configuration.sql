DECLARE @Operator varchar(1000) 
SET @Operator = N'Jeff Shurak'; --add the operator here.  must exist before running this.

/****** Object:  Alert [Error Number 823]    Script Date: 12/9/2013 3:25:41 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Error Number 823', 
		@message_id=823, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'

/****** Object:  Alert [Error Number 824]    Script Date: 12/9/2013 3:25:41 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Error Number 824', 
		@message_id=824, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'

/****** Object:  Alert [Error Number 825]    Script Date: 12/9/2013 3:25:41 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Error Number 825', 
		@message_id=825, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'

/****** Object:  Alert [Severity 016]    Script Date: 12/9/2013 3:25:42 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Severity 016', 
		@message_id=0, 
		@severity=16, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'

/****** Object:  Alert [Severity 017]    Script Date: 12/9/2013 3:25:42 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Severity 017', 
		@message_id=0, 
		@severity=17, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'

/****** Object:  Alert [Severity 018]    Script Date: 12/9/2013 3:25:42 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Severity 018', 
		@message_id=0, 
		@severity=18, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'

/****** Object:  Alert [Severity 019]    Script Date: 12/9/2013 3:25:42 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Severity 019', 
		@message_id=0, 
		@severity=19, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'

/****** Object:  Alert [Severity 020]    Script Date: 12/9/2013 3:25:42 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Severity 020', 
		@message_id=0, 
		@severity=20, 
		@enabled=0, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'

/****** Object:  Alert [Severity 021]    Script Date: 12/9/2013 3:25:42 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Severity 021', 
		@message_id=0, 
		@severity=21, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'

/****** Object:  Alert [Severity 022]    Script Date: 12/9/2013 3:25:42 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Severity 022', 
		@message_id=0, 
		@severity=22, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'

/****** Object:  Alert [Severity 023]    Script Date: 12/9/2013 3:25:42 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Severity 023', 
		@message_id=0, 
		@severity=23, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'

/****** Object:  Alert [Severity 024]    Script Date: 12/9/2013 3:25:42 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Severity 024', 
		@message_id=0, 
		@severity=24, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'

/****** Object:  Alert [Severity 025]    Script Date: 12/9/2013 3:25:42 PM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Severity 025', 
		@message_id=0, 
		@severity=25, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'


EXEC msdb.dbo.sp_add_notification @alert_name=N'Error Number 823', @operator_name= @Operator, @notification_method = 1

EXEC msdb.dbo.sp_add_notification @alert_name=N'Error Number 824', @operator_name= @Operator, @notification_method = 1

EXEC msdb.dbo.sp_add_notification @alert_name=N'Error Number 825', @operator_name= @Operator, @notification_method = 1

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 016', @operator_name= @Operator, @notification_method = 1

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 018', @operator_name= @Operator, @notification_method = 1

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 023', @operator_name= @Operator, @notification_method = 1

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 024', @operator_name= @Operator, @notification_method = 1

EXEC msdb.dbo.sp_add_notification @alert_name=N'Severity 025', @operator_name= @Operator, @notification_method = 1
