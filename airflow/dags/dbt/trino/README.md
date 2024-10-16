Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
```sh
dbt debug
dbt run --select bronze --profile iceberg_bronze --target prod
dbt run --select silver --profile iceberg_silver --target prod
dbt run --select tag:silver --profile iceberg_silver
dbt run --select gold --profile iceberg_gold --target prod
```

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
