external_url 'http://gitlab.rongzhijia.com:7000/'
gitlab_rails['gitlab_ssh_host'] = 'gitlab.rongzhijia.com'
gitlab_rails['time_zone'] = 'Asia/Shanghai'
gitlab_rails['gitlab_email_enabled'] = true
gitlab_rails['gitlab_email_from'] = 'noreply@rongzhijia.com'
gitlab_rails['gitlab_email_display_name'] = 'Gitlab-Bot'
gitlab_rails['gitlab_email_reply_to'] = 'noreply@rongzhijia.com'
gitlab_rails['backup_path'] = "/develop/gitlab-backup"
gitlab_rails['backup_keep_time'] = 604800
gitlab_rails['gitlab_shell_ssh_port'] = 22
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.exmail.qq.com"
gitlab_rails['smtp_port'] = 465
gitlab_rails['smtp_user_name'] = "noreply@rongzhijia.com"
gitlab_rails['smtp_password'] = "rzj@2015"
gitlab_rails['smtp_domain'] = "rongzhijia.com"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_ssl'] = true
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_openssl_verify_mode'] = 'peer' 
user['git_user_name'] = "GitLab"
user['git_user_email'] = "noreply@rongzhijia.com"
unicorn['worker_processes'] = 1
unicorn['listen'] = '127.0.0.1'
unicorn['port'] = 9090
nginx['enable'] = true
nginx['listen_addresses'] = ['*']
nginx['listen_port'] = 7000
