# Image for codeception run tests

FROM ubuntu
LABEL Description="This image is used to run unit, acceptance and functional tests under codeception framework" Version="1.0"
RUN apt-get update
RUN apt-get install curl -y
RUN apt-get install php7.0 php7.0-zip php7.0-mbstring php7.0-gd php7.0-curl php7.0-pgsql php7.0-mysql php7.0-pdo -y
RUN apt-get install default-jdk -y
RUN apt-get install phpunit -y
RUN apt-get install nginx -y
RUN apt-get install xvfb -y
RUN apt-get install firefox -y
COPY test /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/test /etc/nginx/sites-enabled/
RUN apt-get install postgresql -y
COPY selenium-server-standalone-3.3.0.jar /usr/local/src
COPY geckodriver /usr/local/src
COPY codecept.phar /usr/local/bin/codecept
COPY pg_hba.conf /etc/postgresql/9.5/main/
RUN chmod a+x /usr/local/bin/codecept
RUN mkdir project
WORKDIR /project
RUN service postgresql start && su postgres --command 'createuser -w -d -r -s docker' && su postgres --command 'createdb -O docker docker'

#CMD service nginx start
#CMD service php7.0-fpm start
#CMD service postgresql start
#CMD DISPLAY=:99 xvfb-run -a -n 1 -l -s "-screen 0, 1024x768x8" java -Dwebdriver.gecko.driver="/usr/local/src/geckodriver" -jar /usr/local/src/selenium-server-standalone-3.3.0.jar
#CMD codecept run 
