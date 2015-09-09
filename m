From: kieranbingham@gmail.com (Kieran Bingham)
Date: Wed, 9 Sep 2015 15:49:41 +0100
Subject: [Cocci] White space formatting
In-Reply-To: <alpine.DEB.2.10.1509091603370.2798@hadrien>
References: <CAB3z_RouDi7OcMBM3nZx2SKv6NRR6wb0TLRLqzQ9_jE49AHGUg@mail.gmail.com>
 <alpine.DEB.2.10.1509091603370.2798@hadrien>
Message-ID: <CAB3z_RpF=3hXRrEgNCpPS96FUBTYKCt9E+EmNQ_1qQ=jPrVD6w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

...
>> I am using --linux-spacing - but as the help states :
>>   --linux-spacing               spacing of + code follows the
>> conventions of Linux
>>
>> I suspect code is perhaps not refactored on - lines?
>>
>>
>>
>> The lines where I make additions are also not as I desire (aligned
>> with the block) - but I suspect I will have to manually align these or
>> try running lindent:
>>
>> ===========================================
>> -
>>  static struct i2c_driver dm6446evm_msp_driver = {
>>         .driver.name    = "dm6446evm_msp",
>> -       .id_table       = dm6446evm_msp_ids,
>> -       .probe          = dm6446evm_msp_probe,
>> +       .probe2 = dm6446evm_msp_probe,
>
> Yeah, there is nothing to address this.  It's kind of a special case, so
> I'm not sure that there will be anything in the near future either.


Ok - I'm not actually convinced what the kernel style is here ... I've
found lots
of differing blocks in the code, and no mention in the CodingStyle.txt...

Ho hum ... for my patches I will hand edit so that they are the same
as surrounding
code - whatever that may be.



>
>>         .remove         = dm6446evm_msp_remove,
>>  };
>> ===========================================
>>
>>
>> Are there any other ways to control the white-space adjustments made?
>>
>>
>> For reference: I'm on Ubuntu 15.04 with default coccinelle from the distro:
>>   spatch --version
>>   spatch version 1.0.0-rc22 with Python support and with PCRE support
>
> You should upgrade to 1.0.2.
>
> julia


Hmm.. This will be a self compile then.
Ubuntu's latest package is 1.0.0-rc22
 (even on the PPA mentioned on your website:
https://launchpad.net/~npalix/+archive/ubuntu/coccinelle)

--
Regards

Kieran
