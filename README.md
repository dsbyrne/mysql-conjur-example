# mysql-conjur-example
---

## Running the example
1. Load the Conjur policy

   `conjur policy load --as-group security_admin policy/mysql.yml`
   
2. Populate the secret values, either in the UI or:

    `conjur variable values add mysql/password "secret"`
    
3. Start the MySQL container using summon to set the admin password:

    `summon docker-compose up -d`

4. Create a new host using the `create_host.sh` script (you may need to change some container names in the script if it's not working).

    `./create_host.sh`
    
5. The above script will put you into a bash prompt within the container. Navigate to /root and you can use `summon` to run commands:

    ```
    $ cd /root
    $ summon env | grep MYSQL_PWD
    MYSQL_PWD=secret
    ```