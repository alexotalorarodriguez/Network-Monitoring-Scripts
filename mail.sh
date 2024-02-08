#!/bin/bash
###

if ! dpkg -l | grep -q postfix; then
    apt-get update
    #install mail service POSTFIX -------------------------------------------------------------------------------------------------------------------
    apt-get install postfix mailutils libsasl2-2
    apt-get install ca-certificates libsasl2-modules        

    echo -e 'relayhost = [smtp.gmail.com]:587\nsmtp_sasl_auth_enable = yes\nsmtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd\nsmtp_sasl_security_options = noanonymous\nsmtp_tls_CApath = /etc/ssl/certs\nsmtpd_tls_CApath = /etc/ssl/certs\nsmtp_use_tls = yes\nsmtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt' | sudo tee /etc/postfix/main.cf > /dev/null

    echo '[smtp.gmail.com]:587    alexander.otalora@a2odev.com:rgezousmsrgzqrop' | sudo tee /etc/postfix/sasl_passwd > /dev/null

    postmap /etc/postfix/sasl_passwd

    chown root.root /etc/postfix/sasl_passwd*
    chmod 400 /etc/postfix/sasl_passwd*

    /etc/init.d/postfix reload
    #---------------------------------------------------------------END POSTFIX-----------------------------------------------------------------------------------
else
    echo "Postfix ya estaba instalado."
fi
