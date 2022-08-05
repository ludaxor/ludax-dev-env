# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
FROM oraclelinux:7-slim

LABEL Remarks ”This is a dockerfile used from the original repo and modified for the purpose for MLP automation development”

ARG MYSQL_SERVER_PACKAGE=mysql-community-server-minimal-5.7.26
ARG MYSQL_SHELL_PACKAGE=mysql-shell-8.0.16

# Install server
RUN yum install -y https://repo.mysql.com/mysql-community-minimal-release-el7.rpm \
      https://repo.mysql.com/mysql-community-release-el7.rpm \
  && yum-config-manager --enable mysql57-server-minimal \
  && yum install -y \
      $MYSQL_SERVER_PACKAGE \
      $MYSQL_SHELL_PACKAGE \
      libpwquality \
	  ksh \
	  procps \
	  net-tools \
	  telnet \
	  vim \
  && yum clean all \
  && mkdir /docker-entrypoint-initdb.d \
  && touch ~/.bash_profile

VOLUME /var/lib/mysql
ADD packages/WebMonG_MLP_JAVAatHP-2.1.0.61.0.0.1-20181204102949.i386.tar.gz /tmp
COPY packages/EISTools_MLP_SM-1.0.144.1.2-20190705090342.x86_64.rpm /tmp/
RUN rpm -ivh /tmp/EISTools_MLP_SM-1.0.144.1.2-20190705090342.x86_64.rpm && \
cd /tmp/WebMonG_MLP_JAVAatHP-2.1.0.61.0.0.1/package/ ; ./INSTALL_manually.sh && \
mkdir /root/scripts/checks
ADD packages/check_scripts_vem_mysql.tar.gz /root/scripts/checks
COPY packages/jboss7D-test-vem /etc/init.d
COPY packages/functions /etc/init.d
COPY packages/vem-test_profile /root/scripts/profiles
ADD packages/vemtest_mysql.tar.gz /opt/WebMonG/config
ADD packages/monitoring_scripts.tar.gz /root/scripts
RUN chmod -R +x /root/scripts/ /etc/init.d
COPY mysql/docker-entrypoint.sh /entrypoint.sh
COPY mysql/healthcheck.sh /healthcheck.sh
ENTRYPOINT ["/entrypoint.sh"]
HEALTHCHECK CMD /healthcheck.sh
EXPOSE 3306 33060
CMD ["mysqld"]

