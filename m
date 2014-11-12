From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 13 Nov 2014 00:18:15 +0300
Subject: [Cocci] [PATCH v2 1/2] staging: rtl8188eu: Deletion of
 unnecessary checks before three function calls
In-Reply-To: <5463C22B.7060405@users.sourceforge.net>
References: <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <544954FD.8040607@users.sourceforge.net>
 <20141029084702.GA18675@kroah.com>
 <5453CD0D.9010206@users.sourceforge.net>
 <alpine.DEB.2.10.1410311900201.2481@hadrien>
 <5463C10D.6020409@users.sourceforge.net>
 <5463C22B.7060405@users.sourceforge.net>
Message-ID: <20141112211815.GJ6749@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Nov 12, 2014 at 09:25:15PM +0100, SF Markus Elfring wrote:
> @@ -487,8 +488,7 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
>  	DBG_88E("+r871xu_dev_remove, hw_init_completed=%d\n",
>  		if1->hw_init_completed);
>  	rtw_free_drv_sw(if1);
> -	if (pnetdev)
> -		rtw_free_netdev(pnetdev);
> +	rtw_free_netdev(pnetdev);

I still feel that hiding the if statement inside the function call makes
the code more subtle and it is a bad harmful thing to do.  This is
especially true if you have trained yourself to know that free_netdev()
can't accept NULL pointers.

regards,
dan carpenter
