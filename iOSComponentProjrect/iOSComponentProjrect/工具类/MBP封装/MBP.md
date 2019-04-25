    //不会自动消失
    [MBProgressHUD showMessage:@"请稍后..."];
    [MBProgressHUD hideHUD];
    
    //会自动消失
    [MBProgressHUD showError:@"错误"];
    [MBProgressHUD showInfo:@"提示"];
    [MBProgressHUD showSuccess:@"成功"];
