function process_message(~,e)
    
    %convert json string to struct
    message_struct = loadjson(char(e.message)); 
    if(~isempty(message_struct.bb))
        disp('Received Bounding Box:')
        disp(message_struct.bb)
    end
   
    raw = base64decode(message_struct.imageBase64, '', 'java'); 
    
    % decode image stream using Java
    jImg = javax.imageio.ImageIO.read(java.io.ByteArrayInputStream(raw));
    h = jImg.getHeight;
    w = jImg.getWidth;

    p = typecast(jImg.getData.getDataStorage, 'uint8');
    img = permute(reshape(p, [3 w h]), [3 2 1]);
    img = img(:,:,[3 2 1]);
    image(img)
    
end

