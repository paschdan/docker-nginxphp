# Docker Image with nginx and php-fpm for symfony

For using this with a symfony Project simply add a Dockerfile to your project, with following content

``` 
FROM paschdan/nginxphp:symfony

RUN composer install -n
```


