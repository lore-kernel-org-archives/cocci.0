From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 12 Nov 2014 22:28:41 +0100
Subject: [Cocci] [PATCH v2 1/2] staging: rtl8188eu: Deletion of
 unnecessary checks before three function calls
In-Reply-To: <20141112211815.GJ6749@mwanda>
References: <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <544954FD.8040607@users.sourceforge.net>
 <20141029084702.GA18675@kroah.com> <5453CD0D.9010206@users.sourceforge.net>
 <alpine.DEB.2.10.1410311900201.2481@hadrien>
 <5463C10D.6020409@users.sourceforge.net>
 <5463C22B.7060405@users.sourceforge.net> <20141112211815.GJ6749@mwanda>
Message-ID: <5463D109.4020702@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> @@ -487,8 +488,7 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
>>  	DBG_88E("+r871xu_dev_remove, hw_init_completed=%d\n",
>>  		if1->hw_init_completed);
>>  	rtw_free_drv_sw(if1);
>> -	if (pnetdev)
>> -		rtw_free_netdev(pnetdev);
>> +	rtw_free_netdev(pnetdev);
> 
> I still feel that hiding the if statement inside the function call makes
> the code more subtle and it is a bad harmful thing to do.

I find your feedback interesting.


> This is especially true if you have trained yourself to know that
> free_netdev() can't accept NULL pointers.

Do you need to adjust your concerns a bit over time when function variants
provide a corresponding safety check in their implementations?

Regards,
Markus
