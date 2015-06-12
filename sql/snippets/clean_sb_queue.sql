declare @c uniqueidentifier
while(1=1)
begin
    select top 1 @c = conversation_handle from feeds.feeds.cdrs
    if (@@ROWCOUNT = 0)
    break
    end conversation @c with cleanup
end
