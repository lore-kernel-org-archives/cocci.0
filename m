Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33163D68BF1
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xrsdExZKqTlwoTRHJD0ZdQo7yx2uU25FrNS0bU2S5+Y=;
  b=B1sLZhrk836ajK9sR7SgwhbbgTaALxG+3UHNY09pZfeVJDwZJBxb0QCG
   +agcGUwHLvJMqHF1F0Iutmab2Hj57Edfm/sRHcdjYfGmziy1lVDUNuiia
   G4jUYm+NM4YTH1EBEv10BEWKPnzBh3dUYRDzI0RJlFR/NXetC10ePP1N6
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194204689"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22CE9E0D61; Sat, 16 Nov 2024 12:26:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E4730E00B7
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 08:59:36 +0100 (CET)
IronPort-SDR: 673850e6_JGYcwuy+n5RgSCOpst6of/YKBxJG7AR4l4RUUBmvyetmmRG
 jQ04yKHiu+MbF1OKIvW8T05LsCIkeHKzjagVaNA==
X-IPAS-Result: =?us-ascii?q?A0GKBwCoTzhngS6AVdE9HYEJgVOCRIFXMwRTkjGBcoF0M?=
 =?us-ascii?q?J4XgX4PAQMBCwEBQgIEAQEDAQOFAAKKSwIeBwEEMgcOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAhABASIZBw47hXsNgmIBM4IWLA19AQEBAQIBE?=
 =?us-ascii?q?igGAQE3AQQLCw4KLjMBBQEcBjWBYH+CQiMBAgekc4EFQopEeIE0gQGCDAEBB?=
 =?us-ascii?q?twfgWQJCQEKgTSFaoJiAYVpg316Jw+BVUSBPAuCeD6LB4JFhB12JYh/mhVSe?=
 =?us-ascii?q?xwDWTIBVRMXCwcFYEkhLAOCSX+BNoFRAYMPSoMugV4FNwo/gkppSzcCDQI2g?=
 =?us-ascii?q?iR9gk+BJQQFg2yBC4NhZy8DAwMDgzyEBx1AAgELbT01CQsboRiHZpMggm4Bj?=
 =?us-ascii?q?nCgUjQHhB2BXQYMn1kGEy+XQAyTAi6HZJBlqH0CCgcGESOBSw4lgVxNMIMqT?=
 =?us-ascii?q?wMZD44tFohswSNANTsCBwsBAQMJhUMmE4kGgUsBAQ?=
IronPort-PHdr: A9a23:UtvkfRJnVTtKSA/o6tmcuC5vWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEvLM30RSQBN2Tq6odzbaN6+a4AS1IyK3CmU5BWaQPbSNNsd8RkQ0kDZzNImzAB9muURYHG
 t9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oI
 xi7oxjdutMIjYZiJao91wbFrmdVcOhS2W9kOEifkhny68us5pJv7zhct/c8/MNcTKv2eLg1Q
 rNfADk6KW4549HluwfeRgWV/HscVWsWkhtMAwfb6RzxQ4n8vCjnuOdjwSeWJcL5Q6w6VjSk9
 KdrVQTniDwbOD4j8WHYkdJ/gaRGqx+8vRN/worUYIaINPpie67WYN0XSXZdUstXSidMGZ23Y
 ZcRAOUdPOZYt4j9qEUIrRuiHgmnGefjxiZVinPqwaE21uIsGhzE0gM9BdIDqHraotXrOqoMT
 O67z6fIwjrfYPxL2zjw85TIfgw7rP2QQb58bdTdxE8yHA3FlFWQronlMiub2OsXtWiQ8vRtW
 vi1i24/tQ5xpCSvydk2ioLUgY8a10rL9SNjzIkpP9K4UlZ7bsCiEJtMqS6aLZB7QscjQ2Fuo
 ik60LoGtYS8fCgQx5Qq3hjSYOGIfIaU+BzsTvqRIStmi3J/frKynxS//0iix+D+SMS4zUtGo
 CRGn9TQuH4D2ADf58eIR/Zz8Uqs1yiD2Q/c5+xaJU04iKvWJ4Ahz7A+ipYfr0fOECDwlU7rj
 6GWbl0p9va05+njeLnrpZ+RO5Vphg3gMakigMOyDOUgPgQTW2WW+P6w2KP/8UD7WrlGk/w7n
 6bDvJzHJ8kWpKi0CBJL34Yn9ha/FCum38oCnXcaLVJEeQyIgpD1N1zIPfv2F+2wg062nzdu3
 /3GPqPuApHKLnXblbfuZ7d960pFxAs9yNBT+otYCr8OLf/yQEPxu9vYDhg2Mwyw3enrEsly1
 oQbWW6XA6+ZNr3dsUOQ6+4xP+WBYJUZtTX9JvQ/+vLik3w0lUUScKSoxZcXbWq3HvViI0WXe
 3rshdIBHH8XsQUkSuzmkkGNXiRJZ3aqQa084C07B5y8DYrYQoCtgbqB0z2hHp1RfGxGDUqME
 Xjwe4WCQPgDcDiSLdN5kjwYSbihTJcs2Qy2uA/g17VnNvbU+jEftZ/7yNd14PHcmg0z9TFvF
 MSc02SNT3lukW8SRj822rp/oU1nxVuZ36h4ma8QKdsGyvpSTQ4gfb7V1e16Asr7XEqVc96JQ
 UynQtyOBTA3U8J3xt4FeUFmHNu+yBvE2nz5LaUSkumnDZp82avGx3X3O8tngyLK3a9nhFA8W
 sZJKWC8rqp+8QHJAMjOiUrPxPXiTrgVwCOYrDTL9mGJpkwNFVcoCc0tPFgab0rS9pHi41/aC
 qSpEfIhOxdAzsiLLu1LbMfohBNIXqSrI8zQNkS2nWr4HhOU3vWUdoO/d2wbmi7UElAJlRwe5
 16CNA43HCDnpHjRX3R1DVy6W0r36qFlrW+jCEo9zgWEdUpkgra8/FgejOaERvUP06gsvCYno
 i9zWlGn0IGeEMKO8ixmeqgUetYh+BFH2Gbe4hR6JYClJrt+i0Q2dg12uwbx0kwyBNke18ctq
 3wuwUx5LqfwPEppUTSe0NiwP7TWLjK35xWzc+vN3UmY1t+K+6AJ4fB+qlP5vQjvGFBwu3Ngm
 8JY1XeR/PCoREIbTI7xX0Ar9hN7u6CSYy8z4JnR3GFtNq/8uyHL2tYgDu8oghi6eNIXPKSBH
 Q70W8oUYqrmYOAjnR6iZwgcMeZO+bQcO8KgfuGBnqmxM6conT6ri3hG/JEoyliFpE8eAqbD2
 5cIxe3d3xPSDW+tygf89JmtycYYO2J3fCL30yXvCY9Pa7cneI8KDTzrOMir3pBlgIarXXdE9
 VmlDldA2cmzeBPUYUauuG8YnUkRv3GjnjO1ijJulDR85KaW2mrFyv76eRwbN3RjQGhkhE3rZ
 4+ugJpJOSrgJxhsjxaj6UvgkuJXraI5JGDJWUpOYyXsB2VjVKKqsfyFecEFu/ZK+W1HFe+7Z
 16dULv0pRAXhjjiE2Vpzzc+bzi2u5/9knSWkUqlJW1o5DrccMB0nlLE4cDEAOVWxnwATTV5j
 j/eAh69OcOo9JOajcWLvue7XmOnHppdFEujhY+Jsm2w7HdyDBujkuqbntzhGBI9lyjh2JFmW
 D7JoxD1foTwn/7iYKQ3Iw8xXg+6t5QyE5ob8MN4nJwK3HkGmpiZtWEKl2v+K5QT2K7zamYMW
 S9extfU5Ab/30gwZnmNxo//SjCc2p47P4j8Mj5Qg3htqZwUW8L2pPRekCB4o0S1t1fUaPl5x
 XIGzOc2rWUdm6cPsRYsySOUBvYTG1NZNGrijUftjZj2oaNJaWKoabX12lB5mIXrALiE5ApVQ
 m70fIsvBwd078N2KlWK12f8oNKBGpGYfZcIuxuYng2VxeRcLtQ6n+ASiCx7NHjVuXwjwvQ8y
 xt00tvp2erPY3Uo96W/DBlCMzTzbM5G4TDhg5FVmcOO1pyuFJFsSX0bGYHlRvWyHHcOpOzqY
 kyQRSYkpC7RSt+9VUePrV1rpHXVH9W3OmGLcTMHmM56SkDVJVQD0ltJGmxrxthjSl/snIu7L
 A94/mxDuAK+8EAXjLs2b1+nFT6OwWXgIjYsFMrBclwPtlsEvwGNdpbGpuNrQ3MGoNv78F3Le
 jTdP0MSVSkIQhDWWAqlZ+XovIiatbDfX7rbTbOGYK3S+7MCEa7SmNT3lNMhpmjEN93TbCA6X
 7tihRUFDTYhXJ6A0zQXF35OyHmLNp/H4k/6omou8KXduLzqQF69v9PeTesPd4w1q1buxv7cf
 ++I2HQjcGgei8NKnC6SjuBYhQ9aijkyJWP0T/Ja7n+LF/iWwugOXnt5I2tlPc9MpcrQxyFrP
 sjWwpPw37981bsuDktdEEfmgoevbNALJGe0MBXGAlyKPfKIP2+Dxca/eq66RbBK6Ycc/xStp
 TaWFVPiNTWfhnHoUR6oK+RFkCCcOlRXpoi8dh9nDWWrQsjhb1W3N9p+jDt+xrNR5DuCLWkHL
 T11aF9AtJWV5CJcx+p6QilPsiQjIu6DlCKUqeLfL9desPdmBDh1i/MP4Hk+zOgwjmkMT/h0l
 S3O69929gv+w6/fl3w+CkoI9mgY4eDD9V9vMqjY6JRaDHPN/RZWqH6VFwxPvNx9TNvmp6FXz
 NHL0qP1MjZLtdzOrq5+T4DZLtyKNH05PF/nAjnRWUEJRDjtPmjFn0FbjPyI3nmUqJEgrd7rg
 pVEGdo5HBQlU+gXDEhoBolIOJBsQjYtiqKWluYN7Hu66QbUHYBU4s6BWfWVDvHibj2eiPMXA
 nlAiaO9JoMVOIrh3kVkYVQvh4XGFX3bWtVVqzFgZAs5yK2i2Hx/SGQp3ATicAz/uRf79Naxl
 x8yzxR7OKEjqGmq7FAwKV7H4iA3lRtp8T0AqTSQdjfrK+G3R44EU0LJ
IronPort-Data: A9a23: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
 U7Kq6CxD6x6F5DdVWbFez7kvEOsNc+2Iw==
IronPort-HdrOrdr: A9a23:FB83oawywG7IvNmVYI+EKrPw5L1zdoMgy1knxilNoNJuA6ulfu
 SV7YkmPH7P+UwssRQb8+xoV5PwI080maQFhLX5eI3SIDUO21HYV72Kj7GSugEIcheWnoUttp
 uIMZIOcOEYZWIbsS+Q2njfLz9P+qjizImYwcjZ1GlkVgxnZuVN6A1jGh+HHkAefmV77FkCe6
 Z0JPArm9NtQxoqhw2AZ0U4Yw==
X-Talos-CUID: 9a23:ybzDzmwO0XIOEheWYk3oBgU7GOcYXU3Yk03sCF+fEDouR5abFWeprfY=
X-Talos-MUID: 9a23:7rxCMgvh7bjmtsCVhM2nuG04MOpGv/SUEUkon880/PCndgNBJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="101784692"
X-MGA-submission: =?us-ascii?q?MDHoy5IFJzLH1N6uAS3OiyxtFTh00RIFQQk7N0?=
 =?us-ascii?q?BvORZrUb6GtPdSa7nwVvKL1GgAoGGn+B3qRNxdGGq6vRKICF93ilbUcz?=
 =?us-ascii?q?+NzRy1P1QodCHkBH0GoPd5D9kbOW2+viglwlV1wUJmldgXQ2ibrwvvHt?=
 =?us-ascii?q?f2+AvaOTNOvs3W/KHNEbAx6A=3D=3D?=
Received: from mail-wm1-f46.google.com ([209.85.128.46])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 08:59:34 +0100
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431616c23b5so14427515e9.0
        for <cocci@inria.fr>; Fri, 15 Nov 2024 23:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731743973; x=1732348773; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xrsdExZKqTlwoTRHJD0ZdQo7yx2uU25FrNS0bU2S5+Y=;
        b=mPjifopcFSCg3NyXZt95f6tjlokTu40H0/P+xzMcZ62oJJWYZBjEbjpM6aEIS+l/gn
         OudryTnZgo1GXKCZ3gKReGOGXMd3nz1BezUzN2KeHYKnL01Rih/y/EGFJzWHeYvkqtld
         xu93gGcJWLJh8RdxArx7iASGy4S633H4jOPKCCZAY/QevOR/m4g2Rny48ycgtWw8Bgav
         Hia4GJizspiMWv9SZ9Olyrb5buRrw6rsjeaWl9+uhcnIGaI/5z8NxL9UT52jLFVtWRYd
         uy/A8hHvBitvyohDU4ptGea7DDbylH30/1MDO547BfyUav3eBiLEWdH1Pwl2uhPLqcAk
         D9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731743973; x=1732348773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrsdExZKqTlwoTRHJD0ZdQo7yx2uU25FrNS0bU2S5+Y=;
        b=qNscquU0RPfOd1FSgu6UlxclRbBxutIfL5LOZQUXhYTPkAlbl2smXypTRVsGxW8NJ0
         ACZWX2VFHfxIecJIMvi/7XAuI5Up3SBj5IGyZlGn20xk728WjTLHksjrCwa4pbGFs04O
         010vzooZl+Cn9T9iNZH8w+SKBZbJQJm4y+CNtGWz05ucjS4NFoXaCokLIoO0zK3h49Nm
         V+Tt86J8WC30askUTpD9qZ1B5AY4EXgVSzwaBj2Cgv7IoPqQP0DyX5/zZwLn3O914YTN
         srcsteNYRWDvZ+WqIqDCX49jMjrd+9+ryiQVOgimmR8hiLk4FA86dH+FJTWovGkRfE1d
         BAhw==
X-Forwarded-Encrypted: i=1; AJvYcCUkQNo0rn1MP8VMiwBfQ/YKcRfGb02WHW4hvnbimaR2DVv36YGadArMeytSoi3cssFpaSYd/A==@inria.fr
X-Gm-Message-State: AOJu0YySJ0eHBu7TUevL51V7MPh/KrQLTugMX5vHHQVz0RedsdIxrZSZ
	ktxgCiNope2pr8Zj/Le2fQRFu/W9SPFu+GvM/qBTnneLlFk+5qhxyM12g7a/P44=
X-Google-Smtp-Source: AGHT+IHwPca/r8TengkDOJBkzNMy5+IC+M/DjfY5vaIp0XwfqGKX+JdkORZRtZVKPaDZkydKQ4+r2A==
X-Received: by 2002:a05:600c:19cb:b0:431:559d:4103 with SMTP id 5b1f17b1804b1-432defe3203mr49400585e9.7.1731743973417;
        Fri, 15 Nov 2024 23:59:33 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab806e1sm81445685e9.20.2024.11.15.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 23:59:32 -0800 (PST)
Date: Sat, 16 Nov 2024 10:59:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ofir Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Louis Peens <louis.peens@corigine.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-scsi@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	linux-mm@kvack.org, linux-bluetooth@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
	ceph-devel@vger.kernel.org, live-patching@vger.kernel.org,
	linux-sound@vger.kernel.org, etnaviv@lists.freedesktop.org,
	oss-drivers@corigine.com, linuxppc-dev@lists.ozlabs.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Message-ID: <896c656f-6d8c-4337-8464-7557c43a80ab@stanley.mountain>
References: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v1-19-19aadc34941b@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-converge-secs-to-jiffies-v1-19-19aadc34941b@linux.microsoft.com>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 19/22] livepatch: Convert timeouts to
 secs_to_jiffies()
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2064
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/896c656f-6d8c-4337-8464-7557c43a80ab%40stanley.mountain>

On Fri, Nov 15, 2024 at 09:22:49PM +0000, Easwar Hariharan wrote:
> diff --git a/samples/livepatch/livepatch-callbacks-busymod.c b/samples/livepatch/livepatch-callbacks-busymod.c
> index 378e2d40271a9717d09eff51d3d3612c679736fc..d0fd801a7c21b7d7939c29d83f9d993badcc9aba 100644
> --- a/samples/livepatch/livepatch-callbacks-busymod.c
> +++ b/samples/livepatch/livepatch-callbacks-busymod.c
> @@ -45,7 +45,7 @@ static int livepatch_callbacks_mod_init(void)
>  {
>  	pr_info("%s\n", __func__);
>  	schedule_delayed_work(&work,
> -		msecs_to_jiffies(1000 * 0));
> +		secs_to_jiffies(0));

Better to just call schedule_delayed_work(&work, 0);

>  	return 0;
>  }

regards,
dan carpenter
