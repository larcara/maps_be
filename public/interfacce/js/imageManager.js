$(function() {
            $("#image_file").on("change", function()
            {
                var formElement = document.getElementById("image_info");
                formData = new FormData(formElement);
                var files = !!this.files ? this.files : [];
                if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support
                if (/^image/.test( files[0].type)){ // only image file
                    var reader = new FileReader(); // instance of the FileReader
                    reader.readAsDataURL(files[0]); // read the local file
                    //alert(reader.readAsText(files));
                    reader.onloadend = function(){ // set image data as background of div
                        $("#imagePreview").css("background-image", "url("+this.result+")");
                        $("#imagePreview").css("visibility", "visible");
                        <!-- upload on server -->
                        $.ajax( {
                            url: json_url + "museums/saveImage",
                            type: 'POST',
                            data: formData,
                            processData: false,
                            contentType: false,
                            success: function(data){
                                alert(JSON.stringify(data));
                            },
                            error: function(){
                                alert("Chiamata fallita, si prega di riprovare...");
                            }
                        } );
                    }
                }
            });
        });