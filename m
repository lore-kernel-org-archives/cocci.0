Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B56C77B61
	for <cocci@archiver.kernel.org>; Thu, 13 Apr 2023 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EANWpVbp9HfHsGHmqR9B93ddISCKSs2ZnVnGi7NSJ+s=;
  b=Zp5y8MsnFKUtrbgSnVUjNgPqknfyZ5VoeuEPmOz2l9xP/BQgsYwgXH4/
   6ficjOP9z9GuP8rCkJRzbygVk53IknFXMXeHocXi+k1GLlZdOC+sB1e6Z
   xjxAs5joY6iy3WM4zxXIr0qmSAvkr1Fy5DbrRybjyTWRsPN3b94X8w00c
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,194,1677538800"; 
   d="scan'208";a="102957240"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Apr 2023 17:17:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5F5EEE7315; Thu, 13 Apr 2023 17:17:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 349BBE0172
	for <cocci@sympa.inria.fr>; Thu, 13 Apr 2023 17:17:24 +0200 (CEST)
IronPort-SDR: 64381d03_ZZFtlcwCSm5mLtsbjWqQH2PkKvpVmJjmw/+0DkQd3v6eYGq
 YtDhisHG/GXMigS6wDSTFBG9D3Mcbc4O3UV633Q==
X-IPAS-Result: =?us-ascii?q?A0EqAAAZHDhkhwwR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIHohkLgOEMIcujCWEA4FWgUA+DwEDAQ1BAQIEAQEDBDiBU?=
 =?us-ascii?q?4J0AoU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECE?=
 =?us-ascii?q?AEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RICRz4DAyMEGQEBESYBDx8GAiYCAkwLBgEMBgIBAYJ6gigBAzEHrih/M4EBg?=
 =?us-ascii?q?ggBAQacCx8sIlSBXgmBFC0BjFM2hDAnD4FVRIEVJwyBCYIthAuEFIJnkWeIW?=
 =?us-ascii?q?gqBNHSBIA6BPIEEAgkCEWuBEAhpgXlAAg1jCw5vgUljTIF7BAIURRYlBA4DG?=
 =?us-ascii?q?SsdQAIBCzs6PzUGAwsfBlZrAgkjERMFAwsVKkcECDgGHDQRAggPEg8sRAxCN?=
 =?us-ascii?q?zMTBlwBKQsOEQNPgUcEgQqBAQYBJiSeEnIBUjtMMIF6kjuxADQHgiuBVoFZD?=
 =?us-ascii?q?J8NBhMvlwkOBpIkAS6FUYFfkBcgp381gS46gVwzGiSDNk8DGQ+OIAwNCRWDb?=
 =?us-ascii?q?o8JAT4/ND0CBwEKAQEDCQGBVYNwAQGDJIJZAQE?=
IronPort-PHdr: A9a23:dIJ9uxfUaiKL0zJLnSXzH30elGM+utfLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWUG9+Lu7kU1qL/iOPJZy8p2d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbglWhDexe61+I
 Ra1oAnetcQbgZZpJ7osxBfOvnZHdONayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU
 7FWFSwqPG8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XCmp4
 ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWWZNQsNdWipcCY2+c
 oQPFfIMM+VWoYbyqVQAsBuwCxeiBO7xyDBHmnD40LYm0+Q4CwzKwBAsEtwMvXnSsd77NL0SU
 eewzKTQyjvMdelW2TTg6IjTbxsvrvWMXbxqccrQz0kvGB7Og1KXp4P/JTOV1fkNs3OB4+RvU
 eKvhXQnqwB3ojig3cothJfGiZkPxl/Z6yp02YA4LsC3R0Bne9CrCodQtz2EOItsRMMvW3xkt
 SQ1x7MGt5C3YTUGxIg6yxPfaPGKd5WE7xzsWeiRPzt1hXJoday+ihqu/kWuxOnxWMmp3FtUo
 SdJjsTAumwL2hfO6caHUuNw8lm81TqRzQzf9P9ILEIumabGKZMt2KM8moQLvUnHESL6gkv7g
 LKMekgn+uWk8efqb7vgq5SBLYF7kBv+Pb4rmsGnAeQ3LAwOX2+D9OS5073j4FH5TK9Ej/Ioi
 abVqo3VKtoDqq64BQ9azJoj5g6hAzu7ztgUh2cLIExHdR6dkoTkOUvCLO3mAfunhlSjijZrx
 /TIPr37BZXNK2DOnrD7crZn6E5c1REzwcpQ6ZJQBLEBOvPzWkn+tNHDAB42LRe7z/z6B9pjz
 o8eX3mADbeDMKzOqV+I+v4vI+6UaYMIoDr9MeQq5+byjX8lnl8QZbWm3ZwLZ3+kH/RrOF6ZY
 HrpgtcZC2gGpAs+TOrwiF2DSzFffXiyX7hvrg08XYGrF4HOQsWvibqAwCChBbVIaW1cTFOBC
 3Hlc8ODQfhIID6TOsQknj0fXqW6UI4m0zmqtRTm0Px8KffO8SAWsojs2Z5z6vGX3Rc/6TB5E
 eyD3GyXCWJ5hGUFQ3kxxq876QZRw0mC3eBDxbR9FNhX6ukDGlM2PIDRysR2As7/XwbGcMvPT
 lu6FJHuLCswRZod3toHcUthU4Gvgg3G1jinH5cakLuEAJFy+aXZiTy5Bc9+1nyO96gqjl89Q
 coHYW67jKdX9AXJAYPN1UKDmPDuPYYb2mbo/WOE3CLavkRRVAlheb/IUXAWeg3dqtGvogv6R
 riqDvwOOAZHyIbWMqJAZ9vopU9LSPfqJJLVZGfn3y+MGBGOyfuobYfsMzEBwSLbBw4Y1QQS8
 HCuOQU9GiqqoyTVCzkoHE+5Jwvd8O9x4EOmQwdg3gCMYAtxyred5R8TieadVf4JmLkDvXFyh
 S9zGQOY1sjVFsHIig5vZqRabptpxV5d1n/C8SF5MIahKa9KmVMUNQh66RC9ny5rA5lNxJB55
 EghyxB/fOfBiAspn1Kw2JnxPuaSMWzu5FW0bLaQ3FjC0dGQ86NJ6fIiqlylshv6XlE6/SBB1
 N9Ym2CZ+o2MFBAbBLf4SEUq7F5Xo7/AYy8yz5zZ3ztgPPr8qSfMjuogH/Bt0RO8Z5FaOaKAG
 hX1Fpg/DtKtNfdstlyndBMCM8hN+aRyM871P+Ce1vuNO+Bt1CmjkXwB4I151ReU8DFgT+fTw
 5sf6/SfwxfBSDr2ylus2izusaZDYzxaXm+2yCy/QZVUerU3ZoETT2GnP8ywwNx6wZ/rQX9Rs
 lC5VRsA34eydByeYkaYv0UY3FkLoXGhhSqzziBl2zAvoK2F2SXSwuPkPBMZM29PTWNmgB/iO
 4+xx9wdWUGpaUAumn7HrQ7fzrJYub85Am3dW0ZOcADpImskXqbx/ruObshT6Y855D1NWbf0a
 lSbR7jh5hoChnm6RS0Enm99Lm7s48+q+n4ywHiQJ3tysnfDLMR5xBOEocfZWeYUxT0eAi9xl
 TjQAFG4ediv59Sd0ZnZ4YXcHyqsUINedS7zwMaOriy+sCdPCAe8guv1t9npCwk83gfk2tMsW
 SiC/3OeKsH7kr+3N+5qZBwiIVbm6NdhXKx6nJExgp44xnUQwJmYtyli8y+7IZBQ3qTwa2AIT
 DgAzovO4QTr70ZkK2qA24PzUnj1LtJJX9CheStW3ys865sPE6KI9PlfmjMzpFOkrAXXaPw7n
 zEHyPJo5mRIy+0OvQMsyG2aDNVwVQF9NDbvig/OwtSwtqRRa06wfLL22Ec2kd26Db6Eqx1RQ
 z6jI81kR3UvqJwgdguWmHToopnpYtzRcc4eunj221/bgu5ZJYhw3vsGiCx7OH7s6Hgsyuo1l
 xtrjtmxuImKLXko/brsWEcCcGevOIVKpXe01/U7/I7exY2kE5R/Fy9eWZLpSantCzcOrbH8M
 B7IFjQgq3CdEL6ZHAmF6U4goWicdvLjf3yROnQdys1vAReHI0kKyiUdRjYnhdgUEg6wxcruW
 Fh07HYd6xSrz3kEgvItLBT5XmrF8U2NYy03VYPZAR5Y9ABE6G/KPMbY4u85TEQ6ttWx6QeKL
 GKcfQFBC2oED1eFC17UNb6r/dDc8uKcC7n2P77UbL6Js+AbS+aQyMflzN595zjVfJbqXDEqH
 7gh10FER3w8B8nJh2BFVXkMjyyUJ8+D+EXmo3cx9Jrgtq2xBkS2v9vIUeY3U50n+gjq0/3ab
 ajK3nk/cGsejtRWmDfJ0ORNhgdIzXs0KH/0TvJY8nSSBKPIxv0NVkFdNHk1bZoSqfhgjk4Xa
 Ku5wpv0zuIq3qRzUgkYEwW8y4fxIpZUa2ClaAGdXRnNa+7Af2WUhZmwO/z0SKUM3r8N6Fvv4
 3DCQhWlYGjEzWeMNVjnMPkQ3nHBekUA5cfnKEcrUDO7BNP+Nk/rapku02Bwm+ZswCmQfSsVN
 Tw2G69UhpuX6y4QwvB2Gmgaq2FgMfHBgCGBqe/RNpcRt/JvRCVyjeNTpnogmfNT62lfSfp5l
 TG3zJYmqky6kuSJ1jtsUQZf4jdNioWRuEx+OKLfvpBeUHfA9RgJ4C2eERMP79diD9TuvehXx
 L2t3OrrLyxe9tvP4cYGL83TNd7BL3crdxbkWXbVAAYDUT+3JDTfikhaw5TwvjWeqpk3rISpm
 YJbEOYBEgZvSbVDVQI8Ro9nQt8/RD4vnL+FgdRd4HO/qEKUX8BGptXcUerUB/zzKTGfhL0CZ
 h0SwLq+I55AU++zk0FkdFR+m5zHXkTKWtUY6AhodAwpuwNg9HZkT2s8813oYEWh7TVAcJz81
 g5zkQZ4bek3oX305EwrI1PRuCYquEw2hMmjnj2bNjL8ZvTVP8keG2//sE4/NYn+SgB+YFipn
 EBqAzzDQqpYk7pqcW0DYOD0ppZFX/JRH/QsiPo42vydIfklgww0QsSPwEha+a3aBJEkmAZ4K
 faR
IronPort-Data: A9a23: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
 T3SFrAc8PR8LlGFiNv/PsCGvNo=
IronPort-HdrOrdr: A9a23:OWMZlqpahBxsUMI9QYinkB8aV5r/eYIsimQD101hICG9vPbo8P
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWvbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadE/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AmOoEoWm1n+rZ6AfgzhXd4N7GfA/XOVvW70WJHX2?=
 =?us-ascii?q?zMEZKFKGbFBzByq4jjvM7zg=3D=3D?=
X-Talos-MUID: 9a23:5Xap9gpCEswLWKB0+1sez2xdNshH+7WoM0IyoLUJhZOrDhJCNSjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,194,1677538800"; 
   d="scan'208";a="53279969"
X-MGA-submission: =?us-ascii?q?MDEX/Nkt+Iwc6/z+sZx+moYAjm3c5yhdkE+DNd?=
 =?us-ascii?q?+XbrFPObO8P4f2PJ9vPp5yBIZ+W0U8a+ugcOhAPNSihK3RNbwOepHgAu?=
 =?us-ascii?q?aDjui7zkdsXh6vhmEFJ7L1QlUkICj/GOhxRDauHJN+y0NQdhCkwaBClr?=
 =?us-ascii?q?APg04l2MwlmZbXpAo+M6yoXw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 17:17:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681399035; i=markus.elfring@web.de;
	bh=TvPDfLmYIKxUGwmxFDcmw95mjMQfigOvkrRFIR+zLxM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=j9zL2IclxIP3fO1c1BB1kyxEB+bivEd+vl11l9Q0A2wmiGzvpghKBq3FVBd1mvy+I
	 OfMZDP4YKGMTbvmgMkE0lz9GRWYGbAiYJ/WoS4lCKxKIZpfdE8wcHVegMeS3jRsCXZ
	 PhAv4W8dtZ2xwzO3wXSPtuIgb1wQaOjODxn3iuSr24pw+AozKFzPNkxMLPKcldmnB4
	 WIhb4slbjl/1LtW3SmK76DUL/KLdTZO1cClOZWi4lSfAmwVNxG3E3KUvYYM9oHCkc7
	 o6V+QnVt6UXlsIUQyRrcFEH9HqBPyCJnhy4pYpp1QOs4135apuk5K0AHhygIvl8MA8
	 mUIlPfW3zLpag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsKH-1qENLs0AMd-00iiKe; Thu, 13
 Apr 2023 17:17:15 +0200
Message-ID: <624fb730-d9de-ba92-1641-f21260b65283@web.de>
Date: Thu, 13 Apr 2023 17:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jon Maloy <jmaloy@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Tuong Lien <tuong.t.lien@dektech.com.au>, Ying Xue <ying.xue@windriver.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:My9eF/TYCJUkQj+Ax70COiEYsuWf7VfPXzNl9i0FqDTvtSgjA0b
 x3bh4m9oLplQ0ipfTppCEm76CJHi60HrGM/bHpBlyJ4DLhT8q9NWz9Wt8Q4TbP6nh8V05/W
 yBF6ebBT1+G7ycQIWLjf2OD6OR8QhJHLMkxYea42j81JA1IGL3TjObpSbSeFBM+Wm5G3rPX
 3PCSVcU1PrEx8FUIIrT0A==
UI-OutboundReport: notjunk:1;M01:P0:s2Tg1QX+TEo=;DNI15M/iLQxkJmjtN+tMgncbi8n
 q8WkBMLh9BgSB55Pa42SinfIx6aBBE3Ri0dZWhdKetwoGaBkatgs8RJWjgSA9hxr+gdIy23Va
 gdYxCN5pViQ/PsDqGcC//W2MI+6wOA/9YhB0eIDE5djWtR8cnicJZmXUzUwe8w2DSEEbbefP3
 97iJO/dZMIL+NB+wRmkO57ErmldsqRvHIZXWqZGSPcSfDWNk1/POHmxt0BLzEEgQq7qndBvpa
 WwDwHrvcFWANiYvd22bLmNUzEU+y3Wp/bRRc7ciNAVm4Xi+gt1Q/RS8i2SopppFiBKHWPOU4c
 Dy6V6TYKbrk9dXe2EjBI800H0prdg64lhCbDAalenyDFfBdzFSTsBtHNMPDrSFXjZ4WXLIOt4
 iti2D7bGEUgkyiwaqembYLNDR0fWUWS9YS5I6kgLR4zO/VPGzfiBJ3WWKmjT3uWSK3tqtL59d
 QUaoDoGjPEBM189wGGqACusQbbHHZ+VK2Kyylgb+sSNvm47I7tvscTbZ0JYmBL07oR0IZfelN
 rmMD7ZLnts684hUCJh/QWWj2wE+0zHib2aW55uTW1Bh3eMe05UISkO0hxqRtEmxw+Z+S3zE8w
 RGxLTM3QJUtAVcOh/IKCiv5BHhZY+ozwhmA40DgXGWljsqB1L/J3wgxAOxtrAB28276xHaImx
 E3puPIHJFVg1leivuGeHOSVy/IjdoKIedWI62LeD3GMk66L9Kh0qRD5SRd9hknH9aHYFlqYFi
 WTNCFgl3ORwm3M2YUmViIsrsdFjkvjKUi+BwbT39J/Mz+y5dJ2wo0tjkwr1oBkUUZLPLMZqcW
 /F2CXL7YR7r7lQvo6nu+NhS39ow3lAGBt+IB+8gpfWnhfYML8GG6l26BK3/LCIXPKNSEjvYdm
 OfCg8BOfZNZJBOVZoWUMY++7/aGRlWonN1v03iWqRFLHC8pN+w7qQ5MNY
Subject: [cocci] [PATCH] tipc: Reduce scope for the variable
 =?UTF-8?Q?=E2=80=9Cfdefq=E2=80=9D?= in tipc_link_tnl_prepare()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1041
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/624fb730-d9de-ba92-1641-f21260b65283%40web.de>

Date: Thu, 13 Apr 2023 17:00:11 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Ctipc_link_tnl_prepare=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the definition
for the local variable =E2=80=9Cfdefq=E2=80=9D into an if branch at the en=
d.

This issue was detected by using the Coccinelle software.

Fixes: 58ee86b8c7750a6b67d665a031aa3ff13a9b6863 ("tipc: adapt link failove=
r for new Gap-ACK algorithm")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/tipc/link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index b3ce24823f50..5aa645e3cb35 100644
=2D-- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1973,7 +1973,6 @@ void tipc_link_create_dummy_tnl_msg(struct tipc_link=
 *l,
 void tipc_link_tnl_prepare(struct tipc_link *l, struct tipc_link *tnl,
 			   int mtyp, struct sk_buff_head *xmitq)
 {
-	struct sk_buff_head *fdefq =3D &tnl->failover_deferdq;
 	struct sk_buff *skb, *tnlskb;
 	struct tipc_msg *hdr, tnlhdr;
 	struct sk_buff_head *queue =3D &l->transmq;
@@ -2100,6 +2099,8 @@ void tipc_link_tnl_prepare(struct tipc_link *l, stru=
ct tipc_link *tnl,
 	tipc_link_xmit(tnl, &tnlq, xmitq);

 	if (mtyp =3D=3D FAILOVER_MSG) {
+		struct sk_buff_head *fdefq =3D &tnl->failover_deferdq;
+
 		tnl->drop_point =3D l->rcv_nxt;
 		tnl->failover_reasm_skb =3D l->reasm_buf;
 		l->reasm_buf =3D NULL;
=2D-
2.40.0

