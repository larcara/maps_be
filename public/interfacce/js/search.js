        var $campi = '';
        //var $operatore = '<select id="searchOp"><option value="cont">contiene</option><option value="eq">uguale</option></select>';
        var $operatore = '<div style="margin-bottom: 25px" class="input-group"><span class="input-group-addon"><i class="glyphicon glyphicon-tag"></i></span><select class="form-control" id="searchOp"><option value="cont">contiene</option><option value="eq">uguale</option></select></div>';
        //var $valore = '<input type="text" id="searchValue"><button type="button" class="btn btn-primary " onclick="renderFormSearch()">\+</button>';
        var $valore = '<div style="margin-bottom: 25px; " class="input-group"><span class="input-group-addon"><i class="glyphicon glyphicon-barcode"></i></span><input type="text" class="form-control" id="searchValue" placeholder="Inserisci valore da ricercare"></div><div style="margin-bottom: 25px; " class="input-group"><button type="button" class="btn btn-primary " onclick="renderFormSearch()">\+</button></div></div>';

        function urlParams(name){
            var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(window.location.href);
            if (!results) {
                return 0;
            }
            return results[1] || 0;
        };
        function getSectionLabel(data, sectionName){
            var sectionLabel = $.unique($.map(data.data, function(item){if(item.museum_section.section_name == sectionName){return item.museum_section.section_label;}}));
            return sectionLabel;
        }
        function getFieldLabel(data, fieldId){
            var fieldLabel = $.unique($.map(data.data, function(item){if(item.field_name == fieldId){return item.label;}}));
            return fieldLabel;
        }
        function renderFieldSearch(){

            $.ajax({
            type: "GET",
            url: json_url + "museums/getSectionDetail",
            data:{auth_token: urlParams('key'), catalog: ('default'), section: ('*'),filter:{"enabled_eq":true}},
            dataType: "json",
            success: function(data){
                if(data.error != null){
                    //alert(JSON.stringify(data.error));
                }
                else{
                    //alert(JSON.stringify(data.data));
                    var sezioni = $.unique($.map(data.data, function(item){return item.museum_section.section_name}));
                    var campi;
                    $campi = '<div style="margin-bottom: 25px" class="input-group"><span class="input-group-addon"><i class="glyphicon glyphicon-tag"></i></span><select  class="form-control" id="fieldSearch">';
                    $.each(sezioni, function (i, sezione) {
                        $campi += '<option value=\'\'>---- Sezione ' + getSectionLabel(data,sezione) + '----</option>';
                        campi = $.map(data.data, function(item){if(item.museum_section.section_name==sezione){return item.field_name}});

                        $.each(campi, function (a, campo) {
                            //getFieldLabel(data,campo)
                            $campi += '<option value="' + campo + '">' + getFieldLabel(data,campo) + '</option>';
                        });

                    });
                    $campi += '</select>';
                    $campi += '</div>';

                    //alert($campi);
                    $('#searchParameter').append('<div class="row"><div class="col-sm-5 col-lg-5"  id="searchRow"></div></div>');

		            $('#searchRow').append($campi);

                    $('#searchRow').append($operatore);

                    $('#searchRow').append($valore);

                    //$('#searchParameter').append('</div>');
                }
            },
            error: function(){
                alert("Chiamata fallita, si prega di riprovare...");
            }
        });
        }
        function renderFormSearch(){
            var index = $('div#searchRow').length;
            $('#searchParameter').append('<div class="row"><div class="col-sm-5 col-lg-5"  id="searchRow">' + $campi + $operatore + $valore +'<button type="button" class="btn btn-primary " id="btn_remove" value="' + index + '" onclick="removeRowSearch(this,this.value)">-</button></div></div>');
        }
        function removeRowSearch(row, index){
            $('div#searchRow').get( index ).remove();
            var input = $('button#' + row.id);
            $.each(input, function(i){$(this).val(i+1);});
        }

        function emptyValue(value) {
            //alert(value);
            if (value == null){
                value = "";
            } else {
                value = value;
            }
            return value;
        }

        function getResult(){
            $('.nav-tabs a[href=#tab3]').tab('show') ;
            var objFilter = {};
            var listSelectField =$('select#fieldSearch');
            var listSelectOp =$('select#searchOp');
            var listInputValue =$('input#searchValue');
            for(a=0; a<$('select#fieldSearch').length; a++){
                objFilter[listSelectField[a].value + "_" + listSelectOp[a].value] = listInputValue[a].value || '';
            }
            $.ajax({
            type: "POST",
                    url: json_url + "museums/findCard",
                    data:{auth_token: urlParams('key'),filter:objFilter},
            dataType: "json",
                    success: function(data){
                        var fields = '<table class="table table-striped"><thead bgcolor="#CCCCCC"><tr><th>Codice</th><th>Oggetto</th><th>Descrizione</th><th>Scheda</th></tr></thead><tbody>';
                        var result = 0
                        $.each(data.data, function (i, object) {
                           result = i+1
                           fields +='<tr><td>' + object.id_codscheda + '</td><td>' + object.oggetto + '</td><td>' + emptyValue(object.descrizione) + '</td><td><a href="modifica_reperto.html?key=' + urlParams('key') + '&id_codscheda=' + object.id + '">' + object.id + '</a></td></tr>';
                        })
                        fields += '</tbody></table>';
                        if(result==1){
                            $('#searchResultCount').html('<label style="color: #B4886B;font-weight: normal;">Trovato ' + result + ' risultato</label>');
                        }
                        else{
                            $('#searchResultCount').html('<label style="color: #B4886B;font-weight: normal;">Trovati ' + result + ' risultati</label>');
                        }

                        if(result>0){
                            $('#searchResultList').html(fields);
                        }
                        else{
                            $('#searchResultList').html('');
                        }

                    },
                error: function(){
                    alert("Chiamata fallita, si prega di riprovare...");
                }
            });

        }