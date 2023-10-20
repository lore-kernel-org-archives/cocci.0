Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B65C0032E
	for <cocci@archiver.kernel.org>; Fri, 20 Oct 2023 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BylsN7zof9zQNG4IXmjFcOduFF4CEO+8sYGKQxTcy0o=;
  b=ATqvF3vaNPdxDMDgbRmYek+EVZcifp5TEGAF958/WSPD0S06bKGyBoDQ
   bS8p5DO5nkl1tWyPRUw2aGFdG/XCTw/tSpdaERb9DLj2D4DCu6dAoY3lm
   kZZrv0KE7kzNMUamteGMNHjXoWxh2a4vMiEGRO8cYeTh+Fx+CtUZ51sa+
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.03,239,1694728800"; 
   d="scan'208";a="132382675"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2023 17:01:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 08EA6E0CD5; Fri, 20 Oct 2023 17:01:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A70C6E00B7
	for <cocci@sympa.inria.fr>; Fri, 20 Oct 2023 17:01:05 +0200 (CEST)
IronPort-SDR: 65329631_gTl6KfURvn8KU27+WA4kv5q7+Rw51jVY34ZtGR27VowzKdj
 M69ZhfIrMeg/6+cfQ+6kKIPDi7DDQR1WUhzOfsg==
X-IPAS-Result: =?us-ascii?q?A0FWCQAVlTJlh07ASNlagQmBUYI3fVMwBAtIhFOPPIF2M?=
 =?us-ascii?q?IQ7hzOHSYhugxY+DwEDAQ1BAQIEAQEDBIILgmoBCQKHFgIeBwEENQUNAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEjFwcOBQsnhWgNgjcrA?=
 =?us-ascii?q?RGBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgECAgEjHQEBEScECwsaAiYCA?=
 =?us-ascii?q?lcGARQBAYJ6gioBAw4jB7Q3gTKBAYIJAQEGr1QfLCJVgV8JgRoviAkBhVGEN?=
 =?us-ascii?q?ScPgVVEgTyCUzE+hEODW4Jog3aXK14jBUJwGwMHA4EDECsHBC8bBwYJFhgVJ?=
 =?us-ascii?q?QZRBC0kCRMSPgSBZ4FRCoEDPw8OEYJDKzY2GUuCWwkVDDQESXYQKgQUF4ERB?=
 =?us-ascii?q?GofFR43ERIXDQMIdh0CESM8AwUDBDQKFQ0LIQVXA0cGSgsDAhwFAwMEgTYFD?=
 =?us-ascii?q?R4CEBoGDicDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbB82CTwPDB8CBQQOAxkrH?=
 =?us-ascii?q?UACAQttPTUGAwsbBj4CJ51xgmmCDcZLNAeCMYFegV8MnyMGEy+DbgGTLg4Gk?=
 =?us-ascii?q?jmYPCCoMIF7IoFcMxokgzZPAxkPjjmEEo9IPzU7AgcLAQEDCYVGAQGDWoIpA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:ERhTGxc3qruyHRqZi5nz64gGlGM+EtTLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWZG9qLoKIcw6qO6ua8AzJGuc7A+Fk5M7V0HycfjssXmwFySOWkMmbcaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 Au1oAnLtMQbgoRuJ6UtxhDUpndEZ/layXlnKF6Nnhvw/Nu88IJm/y9Np/8v6slMXLngca8lV
 7JYFjMmM2405M3vqxbOSBaE62UfXGsLjBdGGhDJ4x7mUJj/tCv6rfd91zKBPcLqV7A0WC+t4
 LltRRT1lSoILT858GXQisxtkKJWpQ+qqhJjz4LIZoyeKeFzdb3Bc9wEWWVBX95RVy1fDYO6c
 4sPFPcKMeJBo4Xgu1cCsR6yCA+xD+3t1zBInGf706403esuHw7IwRIuH9wOvnvWsNr7O7wfU
 fyszKTS0TnPc+1a1DX75YPVch4hu/aMXbdofMTW00YvDQDFjkiLqYf4MD2V0uoNs3Ka7+pmW
 uKklmkqpQZrrTi1xccsl5LJipgaxFDA+yV52oc1Jdu3SENgb9+rDoBfuzuHOIRoW84vRXxjt
 ykmxLMco5G7YDQKx4o9xx7Zc/GKcpaF7w7/WOuVPzp1hm9pdr29ihux7EStyO7xWtS03VpWo
 SRJjtnCuHAD2hDO98SKS/Vz8Emv1ziB1Q3e9ONJLEYpnqTYM54s2qA8mocRvEjZHCL6hl/6g
 LKSe0k64OSl6efqbq3iq5KTLYN5hBzyPr4tl8G+G+g1NggDUm6G8uqmzrLj51f2QLBSg/02j
 KbZtJfaKNwepq6+Hg9Vzpwv6hihADi9ytgXgGcIIEpEeBKBkYfpJ0nDLO7lAfq9mVihkilny
 +rbMrDlHJnBNHrOnbT5cbZ48UFcyQ4zzd5F55JTD7EMOPX9VVXrtNzbEx85KBa4zenjCNVzz
 IMeWGSPAqCCPaLcr1CH/fgjLPSSa4MNvjbyMOAq5+Tygn8hhV8dYa6p0IMJZHygBPRpP12ZY
 WbwgtcGCWoKuhAxTeLwh12GVT5efHezX6M55j4gEoKpF53PRoGrgLyb3Se0BIdaZm5cClyUC
 3fna52EW+sQaCKVOsJujjsEWqS9RI8gzhyurw/7y79/LuXO4CEYtJTj1MJ05+LJjx0y+yZ0X
 Iyh1DSvUmV1lyssTiA/2KQ39U5gzlaKl6xxnPVcEfRS4elIW0E0L8iYh8lzEczzXEr6ddeT1
 lqrWJ3yADc/Sfoq3NICYl19FtCogxzP0ibsCLgQwfjDD5s/+aP03n7rJs87xWyV+rMmigwDS
 9FMKHbuq6px7QnVCMadtkyDlLuxM4kY0jTM8mir0meE+k1VBl0jGZ7ZVGwSMxOF5e/y4VnPG
 vr3UexP2mppzMeDLvAPcdj1lRBdQ++lPt3CYmW3kmP2BBCSx7rKYpC5M34F0nD7D04J2xsW4
 W7ALRI3UwKouWHDF3pDEVz1YkXj2fZzojW3Qxx81BmEOnVozKH94RsJnbqZQvIX0KgDvXIEo
 i93AU378tbYEduGqCJ+ca8abd5uqExf2zf/sApwdoelM7gkhlMadFFvuFjy0hxsFohauc0ts
 W9s0wd4b66VuL9YXxWf2524erjeK22puQuqd7aTwVbGltCf5qYI7v087VTlpgCgUEQ4oT1h1
 JFO3n2Q64+vbkJaWI/tUksx6xlxpq3LKig76YTO0HRwMK6y+jbc0tMtDeEhx16uZdBaeK+DE
 QbzFYUdCa3MYKQPkkKqcwlCEeRc7q8yMOu5evHA1KPqdOdskTS6jHhWtZhn2xHE/C59R+jUm
 pcdlqvBgU3YDXGl3Q3n7ZCk/OIMLSsfFWe+1yX+UYtYZ6kpOJ0OFX/rOMqvgNN3m5/qXXdcs
 l+lHVIPnsGzKn/wJxTw2xNd0UMPrDmpgyy9mnZRmisqs7HZ8SjA2eXkezIYN2QNSGQo3jKOa
 cCkyssXWkSldV1jsRK/5lvhgYVfqr5+KWb7XkpCOST7ZTIHMOP4pv+JZMhB74ktuCNcXbGnY
 FyUfbX6pgMTzyLpG2Y2KCkTTzixod25mhV7jDnYN3NvtD/Cftk2wx7D5dvaTPoX3zwcRSA+h
 yOFTlS7OtCo+52TmfKh+qibXniiS4YVXC3l14KGuwOk6GcsDRD3k/2om9LhGBQ3ymehjoYsC
 n+O9UemJNa7n62hefpqZExpGEPx568YUslln408iYtRkXkWi5OJ/GYWxGL6MNFVw6X7PzIGQ
 T8GxcKQ4RCwghQ8aC3TgduoDDPCkpgEBZHyeG4d1yMj4tofDa6V6OcBhi5puh+jqhqXZ/Fhn
 zAbwP9o6XgAguhPthB+q0fVSr0UA0RcOjTh0hqS6NXr5oBefmWyav6d0ERknNauJK6PqEdQV
 TyqH/VqVT819ch5PF/WhTfW45vnZcKWQNYdrBySnD/fguITJJ97xZ9ozWJ3fGn6u3Mi0esyi
 xdjiIq7sIawIGJo5KulAxRcO269d4YJ9zrql6obgteO0tXlAMB6AjtSFsiNL7rgAHcIuP/gL
 QrLDDAstiLRB+/EBQHGoEZ+8yCVSsrtbSvIYiBDk5M7HknafhE64khcXS1mzMRgTEbwnpOnK
 Ro/vndLuxb5skcekLsycUOlDSGG+0HwLW1rAJmHcEgMt14EuB2TaJ3EqLgvT2YCr/jD5ESMM
 jDJN14OVD9UHBXZVha7eePwrdjYr7rCX7X4cKGIO+3R77QZDajAxIrzgNE/oHDTbIPWbyMkU
 aF8gBQmPzgxGtyFyWVVDXVJymSXNZ/d/Uzksixv8pLvqrKyBl+pv9DXTeEIecNm/xT86UuaH
 8iXgisxaTNR15dXgGTN1KBax1kKzSdnaziqF70E8y/LVqPZ3KFNXVYdbGtoOc1E4rhZvEEFM
 NPHit7zyr9zj+IkQ1ZDW1v7n8i1ZMsMa2ijPVLDDUyPOfyIPzrOi83wZKq9T/VXgoA2/1Wov
 i2HFkb4IjmZvzzuSgzpLuxGyi2WfVRftIy7bhdxGD3jQdbhOXjZeJd8iTw7x6Fxh2ufbzdDd
 2cmNRoc9PvPvXA94L03AWFK43t7IPPRni+Y67KdMZMKqb5wBTwyketG4XM8wr8T7SdeRfUzl
 jGBy7wm61ygjOSLzSJqFRRUrTMezqeCp0Z/IuP08pdaWHDL1A0A5yOcBl5ZwrktQs2qoK1Wx
 tXVwejrLyxe9tvP4cYGL83TNd7BL3crdxbkUm2xbkNNXXugMmfRgFZYmfeZ+yiOr5Q0nZPrn
 YIHVr5RUFFd/hwyFUlvWtAPcs4fttIMlLmGkIgX6HD4oBSDHK2yW7jYW/jUDfi9cF6k
IronPort-Data: A9a23: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
 FXZjlyojK12pYAd3Cqgl7No9MklgQ7S
IronPort-HdrOrdr: A9a23:A5jUiKyise5uYmrwY0c/KrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:wfITU2Gsp3WQ1G1RqmJq21QRINo1SUbmxVbVORSAJXhyTo2aHAo=
X-Talos-MUID: 9a23:JpnZqwb0jdOlB+BTsQDHinJgC/9RyZ+oJkNOkLw+5PKgDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,239,1694728800"; 
   d="scan'208";a="69328477"
X-MGA-submission: =?us-ascii?q?MDFN0ucIgKsIfjmEp9KLX4nlrzDT+C3v7ckWOr?=
 =?us-ascii?q?P4fYlGY4VsRal25aH+C29KzDo4tO4Ko3/DLLqn9l84aam3Q5+eqRfi/E?=
 =?us-ascii?q?QkjjDVYqwSqg1tJUqYHFg5rL7qWrmmwRKqpw8iKW+TwJszoUzT5TOGgy?=
 =?us-ascii?q?0mli9oMU5NRi9YJ6BaBpR4Qw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 17:01:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1697814062; x=1698418862; i=markus.elfring@web.de;
	bh=lFg+w1iD9LZGrn0F4KchCOKuV5wNB8PYgV5SKW2I+Cc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Z2hmFY39bHZt0NR4Vg0NgkQinPB5H2ePjH6zzwKibfKgsQkfJZAExG3l1Gytrr0+
	 0mI+JXzkeNc0spmaKpfDPSpsqB0EsGU5L91Y5Aj+xCSqfrIrFw+oVb9omh5J+Mc9q
	 sqxnCpK4ByjZjoa7E8t7efjsgL2Vdmva7yPBmWNeYXVOOq5lnO/Zfl9HhkrQl60WV
	 hS8Htf2AqsI9Koi1i++9onU96QNXuhoW7OZ+C3WvGO6NGKYTyO/XDL/haUtpUx0aa
	 eWd9A3LjFN81WLekwEL8nmbkIAgWcNLKF+IBcBpPGA0XBXHqKlNd+XVSeCoaSif6m
	 tATMZvqSd6j3KZR/uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sc1-1qufo90jot-002CBs; Fri, 20
 Oct 2023 17:01:02 +0200
Message-ID: <608e77e0-a36d-44ef-a2fd-9c0c50cf61b3@web.de>
Date: Fri, 20 Oct 2023 17:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 =?UTF-8?Q?Martin_Schr=C3=B6der?= <info@swedishembedded.com>, cocci@inria.fr
References: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com>
 <6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B7lT9uHeEne4OJ2rQOVNZTyp1JSMzTa668cxvy1QEFqnVdqHvNV
 8p67cNHS8xLBhGe92ls4nky6Lj5DwZd6mDQri2rhSAQMb5jJnQ67XyOuHaqZPJNVpD9iXto
 SVZHTKexlyjLodVJGGi0y4krqdAAvjpVW4LUw09VWWZQrdFrJPa+IEUyQx5fhLqF0ZLEph7
 IeAoEjXtZTqbpyHZdzFiw==
UI-OutboundReport: notjunk:1;M01:P0:nTb+hQO+RSg=;Z219zKWO14XxHMnXmR90eWLxFJu
 A2JJHMRPVcoIFGNxi/zTuU3PngU/UO6SttYtQiOBSIgLmHa0xM2F0l6tGP00WxSIYIqZ8lrzI
 95eTfv6saufSshcdeXI3yF7sWqJpT4xsVJYLWyTBcO4pnTu5+l5868x95CfR761gGWc8g/VrP
 BsyYBZ/4zRaHmGzk2VwMJZfyYPfjd01mO84eW+vbCeEtNmJm9pTN1fXmT9mFe0y8gWiPhzEAR
 wmaGf/Tvc3yj865MMtWSggeCK161afWEqVD8Loy2vpln4q+5yRWC/p8osWHkJ+O7P+UxBJ80I
 FCsh/1OqsNax+Gna4pA7Lq6Qv0Bp/ryk1wkLY12inVB3La90tu+L26ZUKV78HsTTR4ydbsh2+
 inRkhOP7ah5DcufSsW2cR2KdgoWpIrBhduZ+RQo5870SicTlyEBuoYhgkKzWHKlIftQScGcwK
 oV5qXmzSrkWg2Baj8cRqG1MUK9UsgxmjMWBVu8p8fs8c1iHhIjbvZ/zbBIdVNY+QMKfVRh4Kc
 JrGi7n0cY+3aGHWhNApMyA3mE5LWyAd2DpEiCj/FX2v+9SV222L9ZFHj1i2b3l8AOO+zR1vJE
 PdzZMjJkjxwtAWEIvxgjWAbhYvfNlhGcv8uzFHQPbjqvApMs5kpHGIUmQpH4pk4gVr25vu5gP
 3yZY/PSiW3mYJsRR5Nmjg1o3sQDMbESQO4nukfyDsABzXdgfhailo3ndoAePCFxsURFkxg22/
 dqsE5TO7qG7WXp2pa6QDu+xwePpn80N5lYEwL9p9/7OVjYcO6s600OkfPWhDC7asO1zxlM8eh
 VhIIPoa5XjUfPED3AP9l662mnf6QytIEgN72HBTgDH7TzuhZ4dAbUQrGhsNgQWTsBIhHOhALJ
 UAUvAIpJszMsaorM6/piNj1L4d2Wq/m0orxiuGczRa5swqZg2C8HOmTy+ZW/bkhnJrKb2p7kj
 rCSmRg==
Subject: Re: [cocci] Finding functions that do not unlock mutex in the same
 function
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1266
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/608e77e0-a36d-44ef-a2fd-9c0c50cf61b3%40web.de>

> I think you could just put
>
> ... when any
>     when !=3D  k_mutex_unlock(l)
>
> and drop the rest.

How do you think about to check the desired consistency of lock scopes
in more detail?

Will any software extensions become helpful for further source code analys=
es?

Regards,
Markus
