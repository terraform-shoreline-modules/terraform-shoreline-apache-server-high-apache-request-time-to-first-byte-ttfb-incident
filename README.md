
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High Apache Request Time to First Byte (TTFB) Incident
---

The High Apache Request Time to First Byte (TTFB) Incident is a type of incident related to web server performance. It occurs when there is a significant delay in the time it takes for the server to respond to a request from a client. TTFB is a metric that measures the time it takes for a web server to send the first byte of data in response to a request. When TTFB is high, it can indicate that the server is experiencing performance issues or that there is a problem with the network connection. This type of incident can impact website performance, user experience, and ultimately, customer satisfaction.

### Parameters
```shell
export SERVER_IP="PLACEHOLDER"

export URL="PLACEHOLDER"

export OLD_VALUE="PLACEHOLDER"

export NEW_VALUE="PLACEHOLDER"
```

## Debug

### Check Apache status
```shell
systemctl status apache2
```

### Check the Apache error logs for any relevant errors
```shell
tail -n 100 /var/log/apache2/error.log | grep -i error
```

### Check the Apache access logs for any requests that have a high TTFB
```shell
tail -n 100 /var/log/apache2/access.log | awk '{if($NF>0.5) print $0}'
```

### Check network connection between client and server
```shell
traceroute ${SERVER_IP}
```

### Check server resource usage
```shell
top
```

### Check disk usage
```shell
df -h
```

### Check memory usage
```shell
free -m
```

### Check server response time for a specific URL
```shell
curl -w "Total time: %{time_total}\n" -o /dev/null -s ${URL}
```

## Repair

### Optimize Apache server configuration: This can involve tweaking settings such as the number of worker threads or processes, adjusting the KeepAliveTimeout value, and increasing the number of concurrent requests that the server can handle.
```shell


#!/bin/bash



# Stop the Apache server

sudo service apache2 stop



# Update the number of worker threads or processes

sudo sed -i 's/${OLD_VALUE}/${NEW_VALUE}/g' /etc/apache2/mods-enabled/mpm_prefork.conf



# Update the KeepAliveTimeout value

sudo sed -i 's/${OLD_VALUE}/${NEW_VALUE}/g' /etc/apache2/apache2.conf



# Update the number of concurrent requests that the server can handle

sudo sed -i 's/${OLD_VALUE}/${NEW_VALUE}/g' /etc/apache2/apache2.conf



# Start the Apache server

sudo service apache2 start


```