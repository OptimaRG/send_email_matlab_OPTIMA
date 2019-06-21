%% Ýbrahim Özþeker - 21.06.2019
%% Mail send function created for OPTIMA Lab.
% mail_list: {'mail_1','mail_2',......}  or 'mail_adress'
%
% header: Header of mail.
%
% content:Content of mail.
%
% variable: Variable that u want attach to mail.

%% Function

function check=OptimaMail(mail_list,header,content,variable)
check=false;
configFile='config.dat';
if isfile(configFile)
    config=readtable('config.dat','Delimiter','=','ReadVariableNames',true);
    email=config.Options{1};
    uname=config.Options{2};
    pass=config.Options{3};
    smpt_server=config.Options{4};
    smpt_port=config.Options{5};
    setpref('Internet','E_mail',email);
    setpref('Internet','SMTP_Server',smpt_server');
    setpref('Internet','SMTP_Username',uname);
    setpref('Internet','SMTP_Password',pass);
    props=java.lang.System.getProperties;
    props.setProperty('mail.smtp.auth','true');
    props.setProperty('mail.smtp.socketFactory.class','javax.net.ssl.SSLSocketFactory');
    props.setProperty('mail.smtp.socketFactory.port',smpt_port);
    
    for tr=1:10
        warning([num2str(tr),'/10 --- ',num2str(10-tr),' try remain.'])
        try
            
            if (nargin < 4)
                sendmail(mail_list,header,content);
            else
                save('attach.mat','variable');
                sendmail(mail_list,header,content,'attach.mat');
            end
            check=true;
            delete attach.mat
            disp('Mail Sent')
            break;
        catch
            check=false;
        end
    end
    % File exists.
else
    error('"config.dat" file is not exist.')
end


end