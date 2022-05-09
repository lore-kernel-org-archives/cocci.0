Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0212FC433EF
	for <cocci@archiver.kernel.org>; Mon,  9 May 2022 10:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DJ9sx2ldTI/OVLa0+wZp2NuVq8ryaUdeUatAVAptTBg=;
  b=Qpp181nrOLDIG/ZwEag6LpQH2wgzygM5tARVjwGAXROu9coFPx1jMMYq
   um+se2qDGBD5dAX9hBQSUhmBUHp5MnGHNl+ZBPiq4ncS9Q6CBATmMrDLz
   82f5Ycuc7GfiB6DObappNpiMjCvKzhgtEIH8uRA/t28rNltFdCHRXwF04
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208,217";a="35326941"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 May 2022 12:06:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A0D43E01BE; Mon,  9 May 2022 12:06:21 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 586A7E009B
	for <cocci@sympa.inria.fr>; Mon,  9 May 2022 12:06:17 +0200 (CEST)
IronPort-SDR: dt9xA4dpRuXfqmgr2T8Llz9sgQl2xc01QVxHegwuqxX+j0xoSmY8jpLyWQ+8DLznNwGofEzZ2a
 uLEVmbAabdC62QLTjj5WK3Xm3AcqrqFKAmuH5r9MajKgKd8ijbcGaPac/lWMFTjqUPlaIhn8Jx
 Jnay+1aI/7jeb+N6WQRsYZTB9ufKQF6TsaOZrLBPMCf7AtrJGOXt68BtBYOtL6ToYGtvS+opB3
 60+THP6yyHC78Y6G6imSrSYmT3qiitEFxTMMhqumywXKyf6gQEdAaLr9T43y0zGs3PuVJHuIuT
 t55T2htBzdkrcM58WINTEs8L
X-IPAS-Result: =?us-ascii?q?A0DTAwB25nhidDPZVdFaHgE8DAILgWSCJDMBgR4uBAtDh?=
 =?us-ascii?q?E6BI41DjU+BBYl4hj+BfAsBAwENQgQBAYpBAh0HAQQwCQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAETAQ4LCQgHCgcODgVgAWEDAUSBT4FPJQsDM?=
 =?us-ascii?q?Q2CNSKEBBEdARseAxIJAQY3AiQBEQEFAT0ahT4BAzGdUIIfgQRBizKBFQUXg?=
 =?us-ascii?q?QGCCQaESwoZKA1nA4FZAgcSgSqGFgIUREoBAYdIEIFVRIFLiEODCYJlBJY8F?=
 =?us-ascii?q?LB0kkQ0B4NMBYE2BgyeNTGoU5ZioWOFKxAjEoEsghVNI1AxgjdOAQIBAQENA?=
 =?us-ascii?q?QIBAQMBAgECCQEBAo4pFoNQimBCMTsCBgEKAQEDCZFvAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:xJi0LKM9ZC0Ciu3vrR2ZkcFynXyQoLVcMsEvi/4bfWQNrUom0TZVm
 GcZCz2HaP6IN2HzeohzOoSz9hxUu5TRytdjTnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EsLd9IR2NYy24DkW1LV4
 LsenuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2upusoz
 s5LsKaZcikjMJfHlP0HTRRXRnQW0a1uoNcrIFC6uM2XilPdKj7inqwoA0YxMokVvO1wBAmi9
 9RCcGFLPk3F3bvphu/iIgVvrpxLwM3DNYcSoWppyz3DCrAtSIrGQqPD+d5w0zI5h8QIFvHbD
 yYcQWM0MUmZPkAVUrsRIJ55mqSRikndSAYbkFOyvaYx6jb+6CUkhdABN/KMIoDQLSlPpW6To
 WnN/kziExQCPZqezyCE+zSinIfycTjTXYsTEPim7acvjgDKgGMUDxISWB2wpvzRZlOCt8x3D
 HUvoyw1q60I3XeFRNfHVBGhumCJsUtJMzZPKNES5AaIw6vSxg+WAGkYUzJMAODKUudmFVTGM
 XfZz7vU6SxTXK69Ei3Cq+/Fxd+mEW1Ecj9YPH5soR4tuoG7+OkOYgTzosGP+ZNZY/XwEDD0h
 i6R9W0w2uxVgskM2KG2u1vAhlpAR6QlrCZluW07vUr/tmuVgbJJgaT2sjA3Ct4edu6koqGp5
 iRspiRnxLlm4WuxvCKMWv4RO7qi+uyINjbR6XY2QcR7r2n0qyTyLNkPiN2bGKuPGpZUEdMOS
 B+D0T69GLcOVJdXRfQqPNruU5pCIVbITI67Daq8giVyjmhZLVfbpkmClGaf2GfilEVErE3ME
 cbzTCpYNl5DUf4P5GPuGY81iOZ3rghjmz67bc2kl3yPjOvGDFbIGOxtGAbfP4gRsvnYyC2Lq
 I03H5XRm31ivBjWO3e/HXg7cQ1QfRDWxPne96RqSwJ0Clc4SDx5V6+NkNvMueVNxsxoqwsBx
 VnlMmcw9bY1rSavxdyiZi8xZbXxc4x4qH5nbyUgMUz5iXcmaIerqqwYcsJvL7Ug8eViy99yT
 uUEK53QWKQRFmyf9mRPd4T5oaxjaA+v2lCDMi+jVz41IMxtSgnPzdn7c1a97yIJFCe26ZAzr
 uT4hAPWSJYOXSp4C8PSZK79xl+9pylPl+d7Xk+OKd5WIR2+/I9vIi33r/k2P8BccUWZlmXGj
 16bWE5Kq/PMrok59MjyqZqF94r5QfFjGkd6HnXA6enkOCTf+F2ly9ASXeuNewfbSzqoqqivY
 ONiz8b8PucCq1BEvtcuCL1s168/u4LiqrIGnARpGHLHMwaiBr96eCLU2MBOsuhT3eYct1bvH
 E2I/dZeNPOCP8a8SAwdIw8sb+Ki0/AIm2mNsa5kfh2ivCInrqCaVUhyPgWXjHAPJrVCNo54k
 /wqv9Qb6lDihxd2YMyKiDtYqzaFInAaCf51s5gbBMr1kVNuxAwbJ5PbDSDy7deEbNAVahsmJ
 TqdhazjgbVAxxqdLyBiSyCVhecN144TvB1qzUMZIwjbkNTygPJqjgZa9i46T1gIwxhKuw6p1
 rOH66GoyWSyEzZUaAxrWmmtH0RfH0Tc9BGojVQOk2LdQg+jUWmlwKjR/wqS1Bhxzo6eVmEzE
 HKkJKLNXjPjfcW31Sw3MaKgg+K2VsR/r2Uuh+j+d/lo3PAGjf7NjaqnZG5OoBziaS/0aIsru
 sEylNtNhWbH2eL8bkH150R2FVjddfxcGFF/fA==
IronPort-HdrOrdr: A9a23:p5+ZQqFzNroDUvZCpLqE78eALOsnbusQ8zAXPidKOHpom62j5q
 eTdZsgtSMc5Ax+ZJhCo6HlBED/exLhHPdOiOF7UNvMYOCMghrLEGgN1/qA/9StIVyaysdtkY
 NbW+xFKOSYNzJHZaqW2njAL+od
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208,217";a="13551552"
X-MGA-submission: =?us-ascii?q?MDGkgeT0APJ0Wor/vOGNey64bVp9jl9vWAi0bS?=
 =?us-ascii?q?xkEJsYb/0R/QXG12c5+VpEJSX5U+/TGACeqawmkXgvVKfiNtx6A+o2M+?=
 =?us-ascii?q?giw5DiKNCNkW2zlDAla6KHVNBgzCz/j8t/3InPimtx8VCt8D22mFbAoJ?=
 =?us-ascii?q?+sBaYFODvOzNNUhXXpYAmJQA=3D=3D?=
Received: from mail-vs1-f51.google.com ([209.85.217.51])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 12:06:16 +0200
Received: by mail-vs1-f51.google.com with SMTP id y74so13297472vsy.7
        for <cocci@inria.fr>; Mon, 09 May 2022 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=DJ9sx2ldTI/OVLa0+wZp2NuVq8ryaUdeUatAVAptTBg=;
        b=gIQ4V8IAc9iIMMa+nO0N92FG66JKUe97Y0aeuzHWcrVt0omZwRSuLpwQkAxNGWq7e4
         /ECodrJWrhyVraR1aB/4/2jHcBMdkjJqGkDp3XVE//LyUEnXOZo8Q6PcuCuGB/2Yn8wn
         ir0pfI/IkKHEa0IjXeGQZNfvjxbcabbM18cPafmJzaiq0Zyd8mppn9dteFUsIGCiSdTf
         6ojmHiewuVdu1Dqds/+n/32H8yS0HHRqRKkg1nBoRo9nuFxV2RuWLzCzAaS6kwQeR38D
         w5xUSFgJau4IQGUzmSAH2IWk4eyJ9qak4FmmUlDYQbp+VhIkLQdSdTRJyI/TbH5/D2vI
         d7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DJ9sx2ldTI/OVLa0+wZp2NuVq8ryaUdeUatAVAptTBg=;
        b=K6U+U/62613a7chDt4xAk+qnkujKpOVI6RzOBeF6kn8BwfCPN4t2OT9mVOQLaa4n4x
         VL1Y7UZ9Zvau2QQlmue14zy68yzYYEsHGNCZuY4UsZRBqO4Cu+f/F/l6FE9Z8of4xD+e
         Ihx2rOAzYoUSCD1aG/+hBzrFsaiOx0SOjtIoNZe9DBgUHBc87HX9IrKf+i5YrburJzuE
         irHS1iZ5VfPK5vVbcJizyNfqPJHxLjsJBQWWFfhE7JcTqwOCBDmyNpeuuL0y2waGaqyF
         IzY7i0wpBOCHd9n3w/QacJo8xBmeYFZaf8ySHFLtoK9zIOxY6CctR/5AdR0FGWnAXdkE
         H3Yw==
X-Gm-Message-State: AOAM531rgmSkeKg4CfWJLVTVOfD3sMW+ownBk6K6JM20HoJzwb0erJnU
	glZshEG2SD6uIRYEvcPbdUicsuJ13pM8nH7AW30T7Sfd3js=
X-Google-Smtp-Source: ABdhPJzgJ0YdnBKFjcpEH7BLd8guO4wRVFKLKo5EF4FaLcsb+ze+EYb2rA/Q7pWXuISADrXabumSRHiSH9sbxNuvHns=
X-Received: by 2002:a05:6102:f14:b0:32d:3afe:8270 with SMTP id
 v20-20020a0561020f1400b0032d3afe8270mr7117555vss.31.1652090774588; Mon, 09
 May 2022 03:06:14 -0700 (PDT)
MIME-Version: 1.0
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Mon, 9 May 2022 12:05:39 +0200
Message-ID: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
To: cocci@inria.fr
Content-Type: multipart/alternative; boundary="000000000000c190d605de915bbd"
Subject: [cocci] List global variables.
Reply-To: Alessandro Carminati <alessandro.carminati@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 365
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ%40mail.gmail.com>

--000000000000c190d605de915bbd
Content-Type: text/plain; charset="UTF-8"

Hello,
I need to build a tool that just lists the global variables for a given c
project.
It appeared to me to be a straight simple operation using coccinelle, still
the script I wrote does not return the expected values.
here the script
```
@g@
type T;
global idexpression T x;
@@
x

@script:python@
x << g.x;
@@
print (x)
```
And this is the simple file I used to test it.
```
#include <stdio.h>
#include <stdlib.h>

static char glid[3];
int cnt;

int function(int a){
return a;
}

int main(){
char *p;
int i,c;
p=malloc(100);
i=function(9);
c=sprintf(p, "Nice text%d\n", i);
puts(p);
free(p);
return 0;
}
```
my expectation was to get "glid" and "cnt" as product for the computation,
instead I just get "function".

Could anybody clarify why this?

cheers
Alessandro

--000000000000c190d605de915bbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div>I need to build a tool that just lists the glob=
al variables for a given c project.</div><div>It appeared to me to be a str=
aight=C2=A0simple=C2=A0operation using coccinelle, still the script I wrote=
 does not return the expected values.</div><div>here the script</div><div>`=
``</div><div>@g@<br>type T;<br>global idexpression T x;<br>@@<br>x<br><br>@=
script:python@<br>x &lt;&lt; g.x;<br>@@<br>print (x)</div><div>```<br></div=
><div>And this is the simple file I used to test it.</div><div>```</div><di=
v>#include &lt;stdio.h&gt;<br>#include &lt;stdlib.h&gt;<br><br>static char =
glid[3];<br>int cnt;<br><br>int function(int a){<br>	return a;<br>}<br><br>=
int main(){<br>	char *p;<br>	int i,c;<br>	p=3Dmalloc(100);<br>	i=3Dfunction=
(9);<br>	c=3Dsprintf(p, &quot;Nice text%d\n&quot;, i);<br>	puts(p);</div><d=
iv>free(p);<br>	return 0;<br>}<br>```</div><div>my expectation was to get &=
quot;glid&quot;=C2=A0and &quot;cnt&quot; as product for the computation, in=
stead I just get &quot;function&quot;.<br>=C2=A0</div><div>Could anybody cl=
arify why this?</div><div><br></div><div>cheers<br clear=3D"all"><div><div =
dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">Alessandro<br><b=
r><div style=3D"display:inline"></div></div></div></div></div></div></div><=
/div></div></div>

--000000000000c190d605de915bbd--
