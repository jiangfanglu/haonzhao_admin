module ApplicationHelper
  

  def iterate_categories category
  	text = category.category_description.name
  	while !category.parent.blank?
  		text.prepend("#{category.parent.category_description.name.html_safe}>")
  		category = category.parent
  	end
  	return text
  end
  def upload_product_image(f,user_id)
	  	require 'fileutils'
	  	tmp = f.tempfile
	    ext = File.extname(f.original_filename)

	    basic_file_name = "#{user_id}_#{Time.new.to_f}#{ext}".downcase

	    file = File.join(Rails.root.to_s, TEMPORARY_FILE_FOLDER, basic_file_name)
	    FileUtils.cp tmp.path, file

	    image = MiniMagick::Image.open(file)
	    size = image[:size]
	    w = image[:width].to_f
	    h = image[:height].to_f

	    ratio = w/h
	    if w > IMAGE_MAX_WIDTH || h >IMAGE_MAX_HEIGHT
		    	if w > h
		    		image.resize "#{IMAGE_MAX_WIDTH}x#{((IMAGE_MAX_WIDTH/ratio).to_i).to_s}"
		    elsif h > w
		    	   	image.resize "#{((IMAGE_MAX_HEIGHT/ratio).to_i).to_s}x#{IMAGE_MAX_HEIGHT}"
		    elsif w == h
		    		image.resize "#{IMAGE_MAX_WIDTH}x#{IMAGE_MAX_WIDTH}"
		    end
		    # add watermark
		    # text_watermark(image,20)
		    image.write file
	    end

	    file_800 = "#{Rails.root.to_s}/#{TEMPORARY_FILE_FOLDER}/#{IMAGE_SQUARE_LARGE_WIDTH}_#{basic_file_name}"
	    if w > h
	    		w = (IMAGE_SQUARE_LARGE_WIDTH*ratio).to_i
	    		image.resize "#{(w).to_s}x#{IMAGE_SQUARE_LARGE_WIDTH}"
	    		image.crop("#{IMAGE_SQUARE_LARGE_WIDTH}x#{IMAGE_SQUARE_LARGE_WIDTH}+#{(w-IMAGE_SQUARE_LARGE_WIDTH)/2}+0")
	    elsif h > w
	    		h = (IMAGE_SQUARE_LARGE_WIDTH/ratio).to_i
	    	   	image.resize "#{IMAGE_SQUARE_LARGE_WIDTH}x#{(h).to_s}"
	    	   	image.crop("#{IMAGE_SQUARE_LARGE_WIDTH}x#{IMAGE_SQUARE_LARGE_WIDTH}+0+#{(h-IMAGE_SQUARE_LARGE_WIDTH)/2}")
	    elsif w == h
	    		image.resize "#{IMAGE_SQUARE_LARGE_WIDTH}x#{IMAGE_SQUARE_LARGE_WIDTH}"
	    end
	    # text_watermark(image,14)
	    image.write file_800


	    file_150 = "#{Rails.root.to_s}/#{TEMPORARY_FILE_FOLDER}/#{IMAGE_SQUARE_WIDTH}_#{basic_file_name}"
	    image.resize "#{IMAGE_SQUARE_WIDTH}x#{IMAGE_SQUARE_WIDTH}"
	    image.write file_150

	    # PUT files to Aliyun OSS code here start
	    files_array = [
	    		"#{basic_file_name}",
	    		"#{IMAGE_SQUARE_LARGE_WIDTH}_#{basic_file_name}",
	    		"#{IMAGE_SQUARE_WIDTH}_#{basic_file_name}"
	    	]
	    	store_aliyunoss_fail = false
	    	files_array.each do |fa|
	    		file_path = "#{Rails.root.to_s}/#{TEMPORARY_FILE_FOLDER}/#{fa}"
	    		begin
		      response = Aliyun::OSS::OSSObject.store(
		        "#{ARTWORK_FOLDER}#{fa}",
		        open(file_path),
		        BUCKET_NAME)
		    rescue Aliyun::OSS::ResponseError => error
		      puts "#{error.code}:#{error.message}"
		    end
		    if response.success?
		      FileUtils.rm file_path
		     else
		      store_aliyunoss_fail = true
		    end
	    	end
	    # Aliyun OSS code finish

	    return {
	    		:image=>image,
	    		:basic_file_name=>basic_file_name,
	    		:store_aliyunoss_fail=>store_aliyunoss_fail
	    }
	  end
  def upload_image_basic_with_filename(f, filename, foldername)
	    tmp = f.tempfile
	    ext = File.extname(f.original_filename)
	    basic_file_name = "#{filename}#{ext}".downcase

	    image = MiniMagick::Image.open(tmp.path)

	    # PUT files to Aliyun OSS code here start
	    	store_aliyunoss_fail = false
    		begin
	      response = Aliyun::OSS::OSSObject.store(
	        "#{foldername}#{basic_file_name}",
	        open(tmp.path),
	        BUCKET_NAME)
	    rescue Aliyun::OSS::ResponseError => error
	      puts "#{error.code}:#{error.message}"
	    end

	    if not response.success?
		      store_aliyunoss_fail = true
		     return "FAILED"
		else
			return basic_file_name
	    end
	    # Aliyun OSS code finish
	  end
  
end
