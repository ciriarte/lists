select * from distribution..MSdistribution_agents
select * from distribution..MSdistribution_history order by time desc
select top(50) * from distribution..MSrepl_errors order by time desc
   
exec sp_browsereplcommands
   
select * from distribution..MSrepl_commands

-- To find the ones that must be updated:

select * from distribution..Mssubscriptions

-- Take a look at the status column:

0 = Inactive
1 = subscribed
2 = Active
Then you can reactivate them by resetting the status to Active:

update distribution..Mssubscriptions set status = 2 where status = 0 and publisher_db = '<YourDB>'

-- Credit to:
-- http://blog.heinozunzer.com/rror-in-replication-the-subscriptions-have-been-marked-inactive-and-must-be-reinitialized/
