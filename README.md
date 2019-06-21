
## Matlab send email function for OPTIMA Lab.

## Usage:

### Input Variables:
1. Edit 'config.dat'.

2. Set function to matlab path.

3. Call function with:
    - **mail_list**: Two type input:
      - If there are multiply adress use cell array ({'mail_1','mail_2',......}).
      - If there is only one adress use string ('test@mail.com').
    - **header**: Header of e-mail.
    - **content**: Content of e-mail.
    - **variable** : Variable that u want to send as attach.mat (optional- if u dont use send without attach)

### Output Variables:

Function return logical true or false.
