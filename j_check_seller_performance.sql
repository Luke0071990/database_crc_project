BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name             => 'CHECK_SELLER_PERFORMANCE_JOB',
    job_type             => 'PLSQL_BLOCK',
    job_action           => 'DECLARE
                              v_start_date DATE := TRUNC(SYSDATE, ''Q'') + INTERVAL ''1'' QUARTER; -- Początek bieżącego kwartału
                              v_end_date DATE := v_start_date + INTERVAL ''3'' MONTH - INTERVAL ''1'' DAY; -- Koniec bieżącego kwartału
                            BEGIN
                              p_check_seller_performance(v_start_date, v_end_date);
                            END;',
    start_date           => ADD_MONTHS(TRUNC(SYSDATE, 'YYYY'), 3), -- Rozpoczęcie od drugiego kwartału
    repeat_interval      => 'FREQ=YEARLY; BYMONTH=4,7,10,1; BYMONTHDAY=1; BYHOUR=0; BYMINUTE=0; BYSECOND=0;', -- Cykliczne powtarzanie co rok, na pierwszy dzień kwartału
    enabled              => TRUE
  );
END;
/

