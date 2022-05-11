# elcep-bss
   
This build is intended to be used in a docker container. Values are calculated for the current day (MSK) or search (<10000) for a value with post-processing in Elasticsearch. Further, this information is transmitted in the form of metrics to pushgateway (https://github.com/prometheus/pushgateway). From which you can then take information to Prometneus.  
   
1. install docker docker-compose   
2. configure settings.conf  
3. start docker-compose:  

  