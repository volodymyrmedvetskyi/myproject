FROM ubuntu/apache2:latest

RUN apt update && apt install wget unzip -y
RUN rm -rf /var/www/html/*
RUN wget https://www.tooplate.com/zip-templates/2136_kool_form_pack.zip
RUN unzip 2136_kool_form_pack.zip && cp -r 2136_kool_form_pack/* /var/www/html/

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"] 
