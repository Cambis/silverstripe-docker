# Apache configuration
ENV DOCUMENT_ROOT /var/www/html
RUN { \
                echo '<VirtualHost *:80>'; \
                echo '  DocumentRoot ${DOCUMENT_ROOT}'; \
                echo '  LogLevel warn'; \
                echo '  ServerSignature Off'; \
                echo '  <Directory ${ENVVAR}>'; \
                echo '    Options +FollowSymLinks'; \
                echo '    Options -ExecCGI -Includes -Indexes'; \
                echo '    AllowOverride all'; \
                echo; \
                echo '    Require all granted'; \
                echo '  </Directory>'; \
                echo '  <LocationMatch assets/>'; \
                echo '    php_flag engine off'; \
                echo '  </LocationMatch>'; \
                echo; \
                echo '  IncludeOptional sites-available/000-default.local*'; \
                echo '</VirtualHost>'; \
	} | tee /etc/apache2/sites-available/000-default.conf && \
    echo "ServerName localhost" > /etc/apache2/conf-available/fqdn.conf && \
    a2enmod rewrite expires remoteip cgid
