helm delete tde

for output in $(docker ps -aq) 
do 
docker stop $output 
done
docker system prune -af
