#/bin/sh
datefmt=$'echo "$(date +\'%F %T.%2N\') [rl.sh]"'

for i in {1..300};
do
    /opt/mssql-tools/bin/sqlcmd -S localhost -l 1 -U sa -P $SA_PASSWORD -d master -i /usr/src/app/mssql_bootstrap.sql -r1
    if [ $? -eq 0 ]
    then
        echo "$(eval $datefmt)    bootstrap completed"
        break
    else
        echo "$(eval $datefmt)    waiting for SQL Server to be up..."
        sleep 5
    fi
done
