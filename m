From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 20 Jun 2018 12:56:50 +0300
Subject: [Cocci] [PATCH] staging: rtl8723bs: Fix two possible
 sleep-in-atomic-context bugs in translate_scan()
In-Reply-To: <20180620095016.8484-1-baijiaju1990@gmail.com>
References: <20180620095016.8484-1-baijiaju1990@gmail.com>
Message-ID: <20180620095650.fga6xi7fyjgybs76@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jun 20, 2018 at 05:50:16PM +0800, Jia-Ju Bai wrote:
> The driver may sleep with holding a spinlock.
> The function call paths (from bottom to top) in Linux-4.16.7 are:
> 
> [FUNC] kzalloc(GFP_KERNEL)
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 323: 
> 		kzalloc in translate_scan
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1554: 
> 		translate_scan in rtw_wx_get_scan
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1533: 
> 		spin_lock_bh in rtw_wx_get_scan
> 
> [FUNC] kzalloc(GFP_KERNEL)
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 455: 
> 		kzalloc in translate_scan
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1554: 
> 		translate_scan in rtw_wx_get_scan
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1533: 
> 		spin_lock_bh in rtw_wx_get_scan
> 
> To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.
> 
> These bugs are found by my static analysis tool (DSAC-2) and checked by
> my code review.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index b26533983864..7632b8974563 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -321,7 +321,7 @@ static char *translate_scan(struct adapter *padapter,
>  		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.Ssid.Ssid));
>  		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
>  
> -		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_KERNEL);
> +		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_ATOMIC);
>  		if (!buf)
>  			return start;

Thanks!  It occurs to me that another way to detect this bug is that
one of the allocations in this function already uses GFP_ATOMIC.  It
doesn't normally make sense to mix GFP_ATOMIC and GFP_KERNEL when there
isn't any locking in the function.

regards,
dan carpenter
