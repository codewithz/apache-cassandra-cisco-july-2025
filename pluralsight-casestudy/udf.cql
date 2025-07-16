create or replace function asTimeStr(duration int, show_sec boolean)
returns null on null input
returns text
language java as $$
    java.time.Duration d = java.time.Duration.ofSeconds(duration);
    long hours = d.toHours();
    d = d.minusHours(hours);
    long minutes = d.toMinutes();
    d = d.minusMinutes(minutes);
    long seconds = d.getSeconds();
    return String.format("%s%s%s",
        (hours > 0 ? hours + " h " : ""),
        minutes + " m",
        show_sec ? " " + seconds + " s" : "");
$$;


 Select module_name, asTimeStr(module_duration,true) from courses where id='react-big-picture' and module_id=2;

 module_name | pluralsight.astimestr(module_duration, true)
-------------+----------------------------------------------
  Why React? |                                    25 m 55 s

(1 rows)
cqlsh:pluralsight> Select module_name, module_duration,asTimeStr(module_duration,true) from courses where id='react-big-picture' and module_id=2;

 module_name | module_duration | pluralsight.astimestr(module_duration, true)
-------------+-----------------+----------------------------------------------
  Why React? |            1555 |                                    25 m 55 s

(1 rows)
cqlsh:pluralsight> Select module_name, module_duration,asTimeStr(sum(module_duration),true) from courses where id='react-big-picture';

 module_name     | module_duration | pluralsight.astimestr(system.sum(module_duration), true)
-----------------+-----------------+----------------------------------------------------------
 Course Overview |              41 |                                            1 h 10 m 44 s

(1 rows)
cqlsh:pluralsight> Select module_name, module_duration,asTimeStr(sum(module_duration),false) from courses where id='react-big-picture';

 module_name     | module_duration | pluralsight.astimestr(system.sum(module_duration), false)
-----------------+-----------------+-----------------------------------------------------------
 Course Overview |              41 |                                                  1 h 10 m

(1 rows)
cqlsh:pluralsight> Select module_name, asTimeStr(sum(module_duration),false) from courses where id='react-big-picture';

 module_name     | pluralsight.astimestr(system.sum(module_duration), false)
-----------------+-----------------------------------------------------------
 Course Overview |                                                  1 h 10 m

(1 rows)