# encoding: UTF-8
# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
HaonzhaoAdmin::Application.initialize!


ARTWORK_PUBLISHED = 1 
MEIDIA_SERVER = "http://oss.aliyuncs.com"
USER_FOLDER = "user/"
ARTWORK_FOLDER = "artworks/"
DELETE_BACKUP_FOLDER = "deletebackup/"
USER_UPLOADS = "useruploads/"
SHOP_FOLDER = "shop/"
TEMPORARY_FILE_FOLDER = "public/uploaded"
COUNTRY_ID = 44

IMAGE_MAX_WIDTH = 1200
IMAGE_MAX_HEIGHT = 800
SMALL_IMAGE_WIDTH = 400
IMAGE_SQUARE_WIDTH = 150
IMAGE_SQUARE_LARGE_WIDTH = 800

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
VALID_MOBILE_REGEX = /^[1][358]\d{9}$/

SHOP_SERVER = "http://localhost"
MEDIA_SERVER_PATH = "media/uploaded_artwork"

BUCKET_NAME = "1shootest"
ALIYUNOSS_ACCESS_KEY_ID = "tZu94MC4MJVTEuvj"
ALIYUNOSS_SECRET_ACCESS_KEY = "e8iglZEc1rKeIv3KbepxnvftGoY7Q7"

HZ_COMPANY_NAME = "上海一树网络科技有限公司"
HZ_COMPANY_NO = "1234567890"
HZ_ECOMMERCE_COMPANY_NO = "1234567890"
HZ_ECOMMERCE_COMPANY_NAME = "asauhdisahduiashdiahduiash"
HZ_COMPANY_CODE = "1234567890"
HZ_RECORD_URL = "http://122.224.230.4:8081/newyorkWS/ws/ReceivedDeclare?wsdl"
AES_PRIVATE_KEY = "qZe60QZFxuirub2ey4+7+Q=="

# Production server 生产机
# BUCKET_NAME = "haonzhao"
# ALIYUNOSS_ACCESS_KEY_ID = "0kU1NCEZUY6q2GH5"
# ALIYUNOSS_SECRET_ACCESS_KEY = "JeeO0O0FqG6F94eUPQpns4BM79kIhB"

MAIN_SITE = "http://localhost:3001"

SITE_ROOT = 'http://localhost:3000'
SOLR = 'http://test.haonzhao.com:8983'