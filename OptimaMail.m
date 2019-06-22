%% Ibrahim Ozseker - 21.06.2019
%% Mail send function created for OPTIMA Lab.
% mail_list: {'mail_1','mail_2',......}  or 'mail_adress'
%
% header: Header of mail.
%
% content:Content of mail.
%
% variable: Variable that u want attach to mail.

% addcontent: True-Add , False - Only send as attachment. default-True

%% Function

function check=OptimaMail(mail_list,header,content,variable,addcontent)
check=false;
[filePath, ~, ~] = fileparts(mfilename('fullpath'));
configFile=[filePath,'/config.dat'];
temp=tempdir;
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
                if (nargin <5)
                    addcontent=true;
                end
                attachPath=[temp,'attach.mat'];
                save(attachPath,'variable');
                if (addcontent)
                    msg=[content,' ',evalc('variable')];
                end
                sendmail(mail_list,header,msg,attachPath);
            end
            check=true;
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