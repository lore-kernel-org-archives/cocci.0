Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3D6C433F5
	for <cocci@archiver.kernel.org>; Fri, 25 Mar 2022 21:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FmSQ4/9NVOZuW/R/2IE1ieCCYiet30/Gxju4giVLVoI=;
  b=X0625q98hrL5nS/JchxY6KifKUZlnolFaLAPb88QeqTkKX6sK0lWse+8
   YvhKr8iXejv2VpC6Q+VO0F7auVryyN3Vok/HDY198nxtXfvXo4rr/ZLgu
   uYPSnbniclC6UAOAPhqIq3zjHl0OUmSgzHtW2JPGeSNN8Z3uDIMXpt8/h
   s=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,211,1643670000"; 
   d="scan'208";a="28207816"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2022 22:40:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DF17EE4370; Fri, 25 Mar 2022 22:40:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EEAB8E436E
	for <cocci@sympa.inria.fr>; Fri, 25 Mar 2022 22:40:43 +0100 (CET)
IronPort-SDR: GX+qsB7P2+FA9PviFRLh9UtHhCyw3/3xwL3/v/bH73g0DIbjIap6dJ0AzY5bvuVKBw8tYMJtjW
 3ygL16EpsG5qTQ9UK6E0cKB/CU26tgT5bZgbTiC0HZInCd+z2MZhJm9ZZsnkHmTFbuo+JnNwHW
 9Uzygdp00YqEer5FkDGepRaGXLpfCo2Z/vIS8hfDC7kRG2xJve+l2B/afxm9JB8rYuJjPraZx4
 7ezob5LG+W/JSfkr7HuNPKeOhvLTHk7U45Ylw8C2kpsGBxv0nkXlZVJ8yepYVH7JnvH/C6+peO
 JsJqQ6sEsBUVDHRC1zrL7nDX
X-IPAS-Result: =?us-ascii?q?A0AuBAAmNj5ihk7ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VoCgiaBVSsEC0SEVJEbiySHGYooE4FoCwEDAQ0SAS0BAgQBAYR9AQkChE4CH?=
 =?us-ascii?q?QcBBDcDDQECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMCwkHC?=
 =?us-ascii?q?AoHDhAFNgZeBmQEgUsEgXQLNA2CNSkBg2QBAgIBIx0BAREmAQQLCxoCERUCA?=
 =?us-ascii?q?lcGDQgBAYMAgmUBAw0lsBKBMYEBgggBAQaESB8sIlKBWwmBECwBjU96JxCBV?=
 =?us-ascii?q?USBPIJTMD6DfoEGgluCZb4/nkU0B4ISgTqBQQyeEQYULoNiAZJgDgaRb5Zco?=
 =?us-ascii?q?WiFG4ILAoFpMxokgzhOAQIBAg0BAgIDAQIBAgkBAQKOHRmEDIosQDQ4AgYLA?=
 =?us-ascii?q?QEDCYVHAQGMFwEB?=
IronPort-PHdr: A9a23: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
 9KJmK+hcF+qFvrL8MFaC8WGcKq6
IronPort-Data: A9a23:zRdkOaz/g+o00w5tx8l6t+dZwCrEfRIJ4+MujC+fZmUNrF6WrkVTx
 2YXX2uObPjba2Onct92YYnipB5QuJ/cnNNqTQA5+1hgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 46q+KUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPht6
 PkUq7qoajwCL4nAoeQ+fV5DSDFXaPguFL/veRBTsOSWyFDaNWThybNiASnaP6VCo7kxXjsIr
 K1Cbm9dBvyAr7reLLaTb+B2hdk4auTvMpkevH5I0jzTS/orKXzGa/SUuY4Dg2pYasZmPvTBS
 ZYEYGFVUjfmeg1XPFIxDckYtbL97pX4W2QF9AzM/PRfD3Lo5Ad227PsGMHEf8SDA8RThEeR4
 Gzcl0z9Cw4TMNi32zuA+GilwO7JhyLyHowIfIBU7dZvh0CPgHMeAlsaWDNXvMVVlGaie/4GN
 WoM2REFvIw+zUyIYJ7mBA2R9SvsUgEnZ/JcFOgz6Qeow6XS4hqECmVscgOteODKp+drHGZ7h
 wThc8fBVGA+6eX9pWe1rO/MxQ5eLxT5OkcuSEc5oeYt5t7+vMcsgxiJQtsL/E+JYj/dSWyYL
 9Oi9nBWa1AvYSgjif7TEbfv3WvEm3QxZlRpjjg7p0r8hu+DWKarZpaz9X/Q5utaIYCSQzGp5
 SZYy5HDsLhSUM/Ry0Rhpdnh+pn2tp5p1xWD0DZS82UJrGjFF4OLINwBvmokTKuXGpxZIGOwC
 KMshe+hzMYOYCXzNPEfj3OZUopzhanmCdn/UP3IJtNBCqWdhyfXlByCkXW4hji3+GB1yf9XE
 c7CLa6EUChGYYw6k2Leb7pMidcDm3FlrUuOFMCT50r8itK2OiXKIYrpxXPVMojVGovf/V2Jm
 zueXuPWoyhivBrWP3CPqNVJfAlQRZX5bLivw/Fqmie4ClIOMAkc5zX5mNvNoqRpwPZYkPnm5
 Ha4VhMKwVbznyOVNgiALHxuMeu9UZF6pHM9HCotIVfxhyl9O9nytv9HestlZ6Qj+cxi0eVwE
 asPdfKANfITGD7JzDIQMMvmp4t4eRX33g+DZnL3YDU2c5N6aRbO/9voIlnm+CUUUHiouMF4r
 7D5jlHXRp8KRgJDCsfKaavzng3r4iVHwLp/BhKaLMNSdUPg9JlRBxbw1vJncdsRLRjjxyeB0
 1jECxkvpd7L/90//u7PiP3WtIyuCeZ/QhFXEmSHv7a7MS7WojiqzYNaCb/aeDfASCXr9a/ka
 egMl6PwN/gOnVBrtYtgEu83nPxkuIa1/+dXnlZ+AXHGT1W3Ebc+cHOI6sl4sPEfzLFuvwbrC
 FmE/cNXOOnSNc65QkQdIhEpMraK2f0Ow2CA6PMoPAPl6SUx8LfeCRdeOByFiSp8KrppMdp5k
 Ll755NMs1Sy2kgwL9KLriFI7GDSfHYOZKUQsM1ICoHcjAd2mEpJZobRC3Ot7ZyCAzmW3pLG/
 tNJaGv+a7VgKo7qdn0uCT7S0OAbiZlmVNWmCrMdDwzhpzYHrqZfMN5tHfAfUQlfiBlKuw62E
 nY+LFV7fM1i4B8x7PWunAmQ98VpGxCTvED8o7fMeKs1UGHwPlHwwKYB1SphMazXH6+wvtSWw
 V1A9FvYbA==
IronPort-HdrOrdr: A9a23:V/014qzviza2YvYM2TKeKrPwCL1zdoMgy1knxilNoNJuA6mlfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIcerIjOPnzEiy792utEuFoDsaEZ2J1m1Ce3um+sYafmN7OaY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,211,1643670000"; 
   d="scan'208";a="9649375"
X-MGA-submission: =?us-ascii?q?MDFzZP1l3pdLpijXGjBXtnHVdT3u2g1UQQ6QIM?=
 =?us-ascii?q?aWlH7WUlHXeg+wgp+UlmE5MJPUqdOyK3TuNLMWYnoIClGQ+wUVGyILnh?=
 =?us-ascii?q?thxGKo9DkFeuK992IqAtQT+bHjqBk1D8UOf60ppsKxYokidk/oPgw9QF?=
 =?us-ascii?q?+Wgd799FrHDMguev9KY0p3hQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 22:40:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648244442;
	bh=FmSQ4/9NVOZuW/R/2IE1ieCCYiet30/Gxju4giVLVoI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C/FaXOjOZ9Tjhbqr10QbNgmyeWkq3uO1AzHxaA8wKXkW5ZqOHV/f8+DyfttpR9WQX
	 l38nBoOg5+486qEGoj159nN/l4AqeWpg7zQbKRAbwZEEUIKB4AHk8+CVmC5xfMTfRr
	 IQuTdwp9CIPtRSsL1fH5evjczDXPLDmZDlr2UaLI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.176.250]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MI3tF-1nJEYX1rIF-00FBSy; Fri, 25
 Mar 2022 22:40:42 +0100
Message-ID: <baf0a457-bbf1-5ff6-ea35-6da6cb4fa0bd@web.de>
Date: Fri, 25 Mar 2022 22:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de>
 <alpine.DEB.2.22.394.2203252223110.4442@hadrien>
 <ce21e395-344a-e58a-4213-69f62a96cb6a@web.de>
 <alpine.DEB.2.22.394.2203252236300.4442@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203252236300.4442@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:O9itM5H+MGLfCXL3uV6OTZLpOY0IU2ju0UMKRw9Wq3tXvMIU+/+
 V3dXgftUG8X0QuYRVqZCHBeQkqdPAe0dAzJ2xFnJCkqZ/ClrStKAUOcsIVYLt3zkxml+UlD
 Md+o/n5xGEwW80tFY8v4tSTnFtaDD2QVAnqsCp9p5sckcuN8v7yb8f+dM7oZBaL4UJ056S3
 I1TN+UGa0H5hGxL1YP3Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DlcqSybEYwQ=:pPqWpD21khHr88Q/lFylfM
 RnIaWBZxBNlSsstmYiaZ7EBm6D/VzEQmh7qdLqzhKgo1SpCd4r5Nh0OYxnAxcQJiPDUt2POWf
 XizPrcVjYZZ+84x17g5VjGwg+VWk4WKxFvJyRmgjj6cfkHzV2u2MQmCDpFKcmHBETpq9yJA8g
 uFBayZf9e1fy9IEOtv6ieLGIjMAOlcMIkXgpOV9kT9/zZYcg1yDUakHdcYzxUpz7qNyJedopD
 Ckxn97QpuF2C+4qiib0CDmZ78GLKtCNIAuuMLmg8r96Dzw2X+vzuWex7WRq7hcYi2YrqyqzN5
 7yMI0xdtpQTsSrvchAJ9mvjUjoD5mxZPEzIhjACjqxyvliUvvQbN0jayywAg2M4HtQOqslpdl
 uvtgS9BGOYtarVWmTUwkcrB1XipCcvNgPK9ob/AvKmUnuohUda+aAm9OC7b/RLi6d4dO15Sg8
 oeB6g0zDj1bcwVKwotp7e2hsWen9u1/782uZ/KuRDXVFH5ZoVVoECoQs/ezDYBUUBhBl1UAO3
 0/ePpMyrLohmbY/TO6P9vaOHd5zbHsiPEpFZkCLnKLNqoChaotQTMemrF6/VaZxJ7LvjXAD/2
 yXNaN25gdw6Z2I9PD32yLrXg/LRg3jreESKzmYNzlKu0BjJKbbFiN9+I0Tww8+sldjUtCtB3e
 451QRuulQp2BpnFKCwnwPfSjwuhS5umDMhG74w6paKC4D+kOgjl6eoMCaVU4Wwk+NkGO5wVen
 jrbA7vj2CUgJWRpM9rgQbVchR+qqRxg3F7d+0dc7d27al4V9Ja3d92l3HxvACqlyt1AvhPlac
 T86jsC3RGbew0nHEPwnPpf/wFj3uc0mnrmHXuHgLHKCrMlus1MJiHJ8pjcikmwzddonju+R5x
 dasd3XF81VfZq4wHqgsimOkG7yPam140ULM+28dhavc04Ao59hgb9AQEM+USV8bAGxZr3sr/Q
 l3Pst/3+0wDG31qu3kdYdDqMfVYRAIrQAVJhEWH/jwHQ1bkW+tQuU+j3rqszid5kkBcCNKkRp
 XHeqHdZi3Ogj+9bqibNBno4bFO8XYUeSFLYECwoFelXUcC4WBIJbc+9aMRMpZacYqvHj7+SQ/
 cZ1ff65Kd6yB5I=
Subject: Re: [cocci] Adding metavariable types for the handling of string
 literals?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 291
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/baf0a457-bbf1-5ff6-ea35-6da6cb4fa0bd%40web.de>


> If you say
>
> - x
> + x
>
> the quotes will still be there.

Would you like to take situations better into account where repeated checks
for double quotation characters should be avoided?

Regards,
Markus
