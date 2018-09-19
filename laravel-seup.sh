## Start by updating to PHP 7.2
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update -y

sudo apt-get install php7.2-curl php7.2-cli php7.2-dev php7.2-gd php7.2-intl php7.2-mcrypt php7.2-json php7.2-mysql php7.2-opcache php7.2-bcmath php7.2-mbstring php7.2-soap php7.2-xml php7.2-zip -y

sudo mv /etc/apache2/envvars /etc/apache2/envvars.bak
sudo apt-get remove libapache2-mod-php5 -y
sudo apt-get install libapache2-mod-php7.2 -y
sudo cp /etc/apache2/envvars.bak /etc/apache2/envvars

## Now let's install Laravel
rm README.md php.ini hello-world.php
sudo composer self-update
composer create-project laravel/laravel ./laravel --prefer-dist
shopt -s dotglob
mv laravel/* ./
rm -rf laravel


#Configure database and .env file database=laravel, user=root, no password
#
sudo mysql --user="root" -e "CREATE DATABASE laravel character set UTF8mb4 collate utf8mb4_bin;"
printf '%s\n' ':%s/DB_DATABASE=homestead/DB_DATABASE=laravel/g' 'x'  | sudo ex .env
printf '%s\n' ':%s/DB_USERNAME=homestead/DB_USERNAME=root/g' 'x'  | sudo ex .env
printf '%s\n' ':%s/DB_PASSWORD=secret/DB_PASSWORD=/g' 'x' | sudo ex .env


#Configure public folder
#
printf '%s\n' ':%s/DocumentRoot\ \/home\/ubuntu\/workspace/DocumentRoot\ \/home\/ubuntu\/workspace\/public/g' 'x' | sudo ex /etc/apache2/sites-enabled/001-cloud9.conf

## Finish by installing PHPMyAdmin
phpmyadmin-ctl install
mysql-ctl start




##### Don't forget the remaining manual steps #####

## And run sudo composer update

## Open the /app/Providers/AppServiceProvider.php file and add:
# use Illuminate\Support\Facades\Schema;
# Schema::defaultStringLength(191); to boot()
