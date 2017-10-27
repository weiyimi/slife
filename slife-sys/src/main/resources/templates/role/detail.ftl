<html>
<head>
    <title>系统用户编辑</title>

    <link href="${base}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${base}/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${base}/css/animate.css" rel="stylesheet">
    <link href="${base}/css/style.css?v=4.1.0" rel="stylesheet">
    <link href="${base}/css/slife.css" rel="stylesheet">


    <link rel="stylesheet" type="text/css" href="${base}/css/plugins/jsTree/style.min.css"/>
    <!-- 全局js -->
    <script src="${base}/js/jquery.min.js?v=2.1.4"></script>
    <script src="${base}/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="${base}/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${base}/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${base}/js/plugins/layer/layer.min.js"></script>
    <script src="${base}/js/jquery.form.js"></script>


    <script>
        var url = "${url}", action = "${action}";

    </script>
    <script src="${base}/js/slife/slife.js"></script>
    <script src="${base}/js/slife/slifeform.js"></script>
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content">

                    <form class="form-horizontal form-bordered" id="slifeForm">

                        <input type="hidden" name="id" value="${role.id}"/>
                        <input type="hidden" name="ids"/>

                        <div class="form-body">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">名称<span class="required">*</span></label>

                                <div class="col-sm-8">
                                    <input type="text" class="form-control" placeholder="录入权限名称" name="name"
                                           value="${role.name}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">编码<span class="required">*</span></label>

                                <div class="col-sm-8">
                                    <input type="text" class="form-control" placeholder="录入角色编码" name="code"
                                           value="${role.code}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">状态<span class="required">*</span></label>

                                <div class="col-sm-8">
                                    <select name="useable" class="form-control">
                                        <option value="Y">启用</option>
                                        <option value="N">禁用</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">描述</label>

                                <div class="col-sm-8">
                                    <textarea name="remark" type="text" class="form-control"
                                              placeholder="请输入角色描述">${role.remark}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">菜单树</label>

                                <div class="col-sm-8">
                                    <div id="menuTree"></div>
                                </div>
                            </div>
                        </div>


                    <#if action !='detail'>
                        <div class="form-actions fluid">
                            <div class="col-md-offset-3 col-md-9">
                                <button type="submit" class="btn green">保存</button>
                            </div>
                        </div>
                    </#if>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="${base}/js/plugins/jsTree/jstree.js" type="text/javascript"></script>
<script type="text/javascript">
    var tree = $("#menuTree").jstree({
        "checkbox": {"keep_selected_style": false},
        "core": {
            "multiple": true,
            "animation": 0,
            "themes": {
                theme: "classic",
                "dots": true,
                "icons": true
            },
            "check_callback": true,
            'data':${menuTree}
        },
        "plugins": ["wholerow", "checkbox"],
    });


    $("select[name=useable] option[value='${role.useable}']").attr("selected", "selected");


    /**
     *  标志选择了的菜单
     */
    function selectMenuId() {
        var array = $.jstree.reference('#menuTree').get_selected(true);
        var ar = new Array();
        if (array) {
            for (var i = 0; i < array.length; i++) {
                var a = array[i]
                ar.push(a.id);
                if (a.parent != "#") {
                    ar.push(a.parent);
                }
            }
        }
        $('input[name=ids]').val(ar.join(","));
    }

    function  cusFunction() {
        selectMenuId();
    }

    var form = $('#slifeForm');
    var error = $('.alert-danger', form);
    form.validate({
        errorElement: 'span',
        errorClass: 'error',
        focusInvalid: true,
        messages: {
            code: {remote: "角色编码已存在"}
        },
        rules: {
            code: {
                maxlength: 64,
                required: true,
                remote: '${base}/sys/role/check/${role.id}'
            },
            name: {
                maxlength: 64,
                required: true
            },
            active: {
                required: true
            }
        }
    });

</script>
</body>
</html>