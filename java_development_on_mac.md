## Dev Environment Setup

Prereqs:
1. sdkman with Java 8
2. Tomcat 8 installed by homebrew
3. Make sure JAVA_HOME is set. Mine is set by sdkman to JAVA_HOME=/Users/winston.kotzan/.sdkman/candidates/java/current

In Tomcat server.xml I changed this connector port to 8086 to not conflict with my other apps running:
```
    <Connector port="8086" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
```


### Tomcat Quick Reference

to run it:
`https://winstonkotzan.com/blog/2019/02/05/how-to-connect-docker-to-a-postgres-database-on-host-machine-localhost.html`

configuration (port, etc) is at:
`/usr/local/Cellar/tomcat@8/8.5.41/libexec/conf/server.xml`


to manage available applications:
`vim /usr/local/Cellar/tomcat@8/8.5.41/libexec/conf/tomcat-users.xml`




Sources:
1. https://premaseem.wordpress.com/2018/02/03/install-apache-tomcat-on-mac-using-brew/