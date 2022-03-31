Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2120C433F5
	for <cocci@archiver.kernel.org>; Thu, 31 Mar 2022 09:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:in-reply-to:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=oX1YHHz64X01rWaYta9PxOZA+Y+SF6YtCioIoccBc88=;
  b=KByimuTAurBbGXNW8ZTAMwYf+eflOAFNo7hP5bvQ4Vlr1aiKhjca/PBV
   6chXxhmDaEIh/6/yvw4a4nwmjbF8oqN/uBsT5so8rhxPNJd4mqz3x11ga
   sK6gq1xqH7AArAtEY6ABDSHOQYLR/L02zQqsR8Ly+tFji+GwxwoKLgPuM
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@oracle.onmicrosoft.com
X-IronPort-AV: E=Sophos;i="5.90,224,1643670000"; 
   d="scan'208";a="29269044"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Mar 2022 11:15:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 35282E033A; Thu, 31 Mar 2022 11:15:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D825EE00F6
	for <cocci@sympa.inria.fr>; Thu, 31 Mar 2022 10:14:31 +0200 (CEST)
IronPort-SDR: WjpzDLToVEeL/iDd7knJmpMtkTYHi5V194nJDgkqoF8DpbCeBM9xEH9qRhgE+Kq+X50qiqCS+a
 mbDI3o2eXBOlfN6wAASWsCAC4YrNe1vfjJzvilnUTI0CTLl/2xJdWKZ2pgAAUI8YqCK4KB35VR
 X9BipFboYpFjCKQRD3axQNNcaJdyCGcnC+IRTkNvLrkWfS5VdGrzd6vM0jq5yk9m+IpQyRBtAS
 qMCBNhJknivGcyncbNIPQlE19Kc6XrbZg+3hEmXkBB9HKPFeo+EeoHftPu8OheyUPJdcbvHliR
 87gmv7JyL3zlQaZRDIh/Y3fy
X-IPAS-Result: =?us-ascii?q?A0BYAQCDYUVihyCl3M1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VqBUlaCAAQLRIgfAQGFOYgVkUSLNoERA1QLAQMBCwEBQwQBAYUHAoRXAh0HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEBCw0JBQgKB?=
 =?us-ascii?q?w4QBTxkgQgBgU4BgVMLAzENgjUpAYNkAQEBAxIoBgEBNwEPCxguFB4rNYJig?=
 =?us-ascii?q?mYDLgGhJAsBgToCgQ4HiQkBAQF2gTOBAYIIAQEGhRMYXIFcCYE8gxGLPScQg?=
 =?us-ascii?q?VVEhD8+gVOCPQESAYV+IpkkgxhpMpUYjHudbTQHg0yBOwYMnhJNEag9hHWRa?=
 =?us-ascii?q?aIKhFcCBAIEBQIOAQEGgXhrI3BNBB+DOU4BAgECDQECAgMBAgEBAQkBAQEBj?=
 =?us-ascii?q?h0ZHoM7imFyOAIGCwEBAwmRYAEB?=
IronPort-PHdr: A9a23:eXVRoBDSvm0SWxAm37cXUyQUYkkY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua83ygaXBs6CsasMotGVmpioYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2+5YPfbx9ViDe8b75+I
 wi6oRvMusILnYZsN6E9xwfTrHBVYepW32RoJVySnxb4+Mi9+YNo/jpTtfw86cNOSL32cKskQ
 7NWCjQmKH0169bwtRbfVwuP52ATXXsQnxFVHgXK9hD6XpP2sivnqupw3TSRMMPqQbwoXzmp8
 rxmQwH0higZKzE58XnXis1ug6JdvBKhvAF0z4rNbI2IKPZyYqbRcNUHTmRDQ8lRTTRMDI28Y
 YUREuQPPuhYoJXgqFQMoxSxChKhBP/zxjJSmnP6wbc33/onHArb3AIgBdUOsHHModv7LqgSV
 /2+wbfSwjXZd/NZxzH96JTWfRA7vPqBWq9/ftDXyUU1CwzKlE+QqZT7MDOTyuQCrXKb4vFnV
 eK1kWEotwVxrSa1ysgwjYnJg5sYx1bZ/ip23Ig7P8e3SFJnYdG6CptQsTmXOo9rT84tXm1lu
 yk3x6AbtJC7fiUHxpopyRHRZvGZboSF/BzuWeSMLDp2hH9oZLCyihWz/EW+yuDwS9S53UpUo
 idDj9LCtWgN2gTN5sSbSvZx5Fmt1SiT2wzJ9+1JIEA5mbDVJpI/2rI8iJsevVjNEyLzhUn6k
 LSZe0Qh9+Wm9+jrf7DrqoGBOIJxjwzyLKcjl8qiCuoiKAcORXKU+eGk2b3j40L5RLJKg+Uzk
 qjWrJzVP90XqrKlDwNJ04su7xi/Ayu43NgChXkHNFJFeBWcj4j1JV7BPer0Auu4g1SpiDtrx
 vbGMaP9ApjVMHTPjLfscaxj50JC1AY/181T6pNUB70bLv//RFf9tNnCAR84Nwy0zfznCNJ41
 o4GRG2AGKmZPLnOvlCS/OIvO/eDZIkJuDnjMfgo/PnujWUjllABeammw4EbZ2y/HvRjO0mZZ
 2Hjjc8bEWgWpgo+UPDqiFqaXDJNf3qyRb4z5iknCIK6CofOXpyigLud0yinH51bfXtGC1CJE
 XfwbYqIQfYMaCSIIs9giDMIT7ahS5U52RG0qAD606ZnLvbT+iAAsZLsztZ06PfXlRE27jF1D
 sWd02SWQGFuhGwEXT423KZloUx80FiPy6Z4g+YLXeBUst9ATAY2fbHb0KQuB9nsWw7OecihR
 1GhTdGrRzo2S4Ri7cUJZhNREtPqpRnZxyesH7IP3+iHDZpy+avGx3X3O8tn43Hc3aIlgh8tR
 c4ZZj7uvbJ26wWGX92BqE6ejav/MP1EhEYllU+GxGuK5gRDVRJoFL/CVjYZb1fXqtLw4gXDS
 aWvAPIpKFgJ0taMf41NbNChllBaXLH7It2Lb2u33Wy5Hw6FwK+BdqLtYWwW2CibA08BwEgI5
 XjTDQElHW+6pn7GSjlnFFbheUTppOV3rjWwR1UswgeWYldJ0KC88RoYw/ebTqBbxaoK7QEmr
 Tg8B1Ohx5TWBt6H8hJmZ7lZaMgh7U1v0HKBvkklZsT+fq463BgGawRwpF/j21N8DYAofdECi
 nQswUIyLKuZ1AkEbDaExdXqPbaRLGDu/RepYqqQ21fE0d/Q9L1doPI/407uug2kDC9Auz1uz
 sVV3n2A557LEBtaUJT/VVwy/gR7oLeSazc05ofd33lheaeutTqK19UsDeojghGuGrUXeK+NE
 kn5GtcCCs6yJfYCnEKgZRYJeutV8e98Ps+rceeHxL/+JPxpz1fExSxM5IFw1F7J9jIpELaVm
 cxfm7fBgFbBDG2v6TXp+tr6ko1FezwIS2+2yCy+QZVUerU3Z4EAT2GnP8ywwNx6wZ/rQX9Rs
 lC5VDZkkIekfwSfa1vl0Ehez0MS9DarkC3+xDVuizwvsqeF9CvUyu/meVwMPWsBFwwAxR/8Z
 JO5idwXRh3iYwEv0hCs/173wbRWvox4NWDYRUoOdC/zZTIHMOP4pv+JZMhB74ktuCNcXbGnY
 FyUfbX6pgMTzyLpG2Y2KCkTTzixod25mhV7jDjYN3NvtD/Dfso2wx7D5dvaTPoX3zwcRSA+h
 yOFTlS7OtCo+52TmfKh+qiyXmTnXZRJaSTt0Y6anCyh7GZuDFu0mPX7ltD8EAc82DP2zJEwD
 XiO9kykJNC1iuLha6puZSwKTBfk5tB/G51in4d4n5wW1XUAx92U8XcBjWbvIIBe0KP6YmAKQ
 G1uoZad6wzk1Ut/a3ORktihCzPHmJMnPofnJDhMiUdfp4hQBayZ7aJJh35wq1u890fKZORl2
 y0awr0o4WIbhOcAvEwsyD+cC/YcBxo9X2SkmhKW4tS5tKgSanyodO362EN429uoFqmPpB1RQ
 l7+YJ4pGSI25cJ6egGpsjW7+sT/dd/cYMhG/BGdlVHLhvJNJZQtm+AigjBuMmbw+3YizqRo6
 H4mlYH/t4+BJWJ3+au/CRMNLTz5afQY/TT1hLpflMKbjMi/W49sETIRUN70XOqlRXgM4O//O
 V/EQ1he4j+LXKDSFgiF5AJ6omLTRtq1YmqPKiBRzM0+FkPFeQoF2lhSBWpl2MVjXgGymJ67K
 Bo/vGpJoAem910XkKgA2wDXdGDZqU/obz41TMLaNx9K9kRY4EyTN8WC7+V1FiUe/5u7rQXLJ
 HbJLwJPRXoEXECJHTWBdvGn+MXA/u6EB+G/M+qGYLOArvZbXuuJwpTn25Vv/jKFPMGCdnd4C
 Phz1k1GVHF/U8PX/ldHAzQQjD7IZtWHqQ2U/z0vp4XnqKy1CQy3v82XE7tVKsli91a9hqLCf
 ++ciSBlKCpJg5MBwXibrdpXlFUWiixoa3ysCeFa7XOLFviI3PYJUlhAMXAWVoMA9a830whTN
 NSOj9r00uQ9lfspExJfUlennMi1ZMsMKmX7NVXdBU/NOq7VQF+Di8zxf664TqVdyetOsBjl8
 zqSFQnoNy6bmj/1WgqHNvtFhyWWehdZvcvuF3QlQXimV9/gZhChZZVviiYqxLQvmn7QHWsMa
 TE5KxsV8OyetXkemu1/HHdd43YjJu6B0XX8jaGQOtMdtv1lBT5xnuRR7SEhyrdb2ypDQeR8h
 CrYqtMGS7SOlfOGwT5qFhFJr2QT7GpklUJ4MK7d+99LXnOWpXrlDE2VG0wD4oM9UoO+tfgKj
 MDXlKXoNDpOtdnT+JlEb/U=
IronPort-Data: A9a23:/1UeC6JU9PTmLlTRFE+RC5MlxSXFcZb7ZxGr2PjKsXjdYENSgTwHz
 2IWCDuBafyLYjegL493bYmzoUoFuseHn4dqGgod+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhWFjU4
 YqaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhmYBXk
 Ox275aKRSgXF6f1o8QhaQlSOnQrVUFG0OevzXmXtNzLxgieKyOykvs2VgcuJY0f4fp6DSdF8
 vlwxDIlNEjewbjsmPTiFLQq3Z5LwMrDZOvzvllsxDefBv88WZ3FX6jQzdhC1Tw0i4ZFGvO2i
 88xM2s1MEufO0En1lE/Joh5xemI3VbDbn50jE6+l60zylniw1kkuFTqGIGPJobQHZs9clyjj
 mnB9G/4KgoLMcSWjzuD6HOlwOHV9Qv/UZ0bELmQ5P9vikeagG0VEhwfE1WhycRVkWa7S4pWb
 hRMonR/o/BoslSzTt7mQxC05nWDu3bwRua8DcU8uCfV85GO6TyVKVYtRAd6SOAcpMUfEGlCO
 kCyo/vlAjlmsbuwQH2b96uJoT7aBcTzBT9aDcPjZVtdi+QPsL3fnTqUEYk+SP/dYsndXGCvk
 2rT/UDSkp1K1ZZTv5hX62wrlN5Fm3QkZgslvgySBjr9sFJ3PNTjf5So7kPH4PoGJ4GcJrVgg
 JTms5fChAztJcvU/MBofAnrNOzwjxpiGGCE6WOD57F7q1yQF4eLJOi8Gg1WKkZzKdojcjT0e
 kLVsg45zMYNYCv0M/IvO9rqW5RCIU3c+TLNBqi8gj1mMsAZSeN71H0GibO4hT+0yxZEfV8XY
 MrLLpzE4Ykm5VRPl2DqHb1Fj9fHNwgm32TUS4j8zhK7lfKfYnXTIYrpw3PeBt3VGJis+V2Pm
 /4Gb5Xi40wGDIXWP3eLmaZOcwFiBSVqXfje9p0MHsbec1oOMD96UZf5n+h+E7GJaowOy48kC
 FnmBhQHoLc+7FWbQTi3hodLM+23B88l/SNmZUTB/z+AghAeXGpm149HH7NfQFXt3LULISdcQ
 6ZXdsOeLO5ITzibqT0RYYOk9N5lbh2ggQ/INC2gOWBtc5llTg3P29nlYgqypXZWUnDv7ZMz8
 ++6ywfWYZsfXAA+XszYX/SikgGqtn8HleMuAkbFe4EBeEjl/IVwBTb2i/s7f5MFJRnZn2PI0
 ByfChMV4+LKptZtotXOgKmFqaavEvd/QxsFRzWBte7uOHCDrGS5wIJGXOKZRhznVTv5qPe4e
 OFY7/DgK/lbzlxEhIxxTuRwxqUk6tqz+rJXw1g2HHjPaFj3WLpsLmPcg5tKpvVEg+cB4VXnV
 BrVvMFCObKSJM7pVlUWIVN9POiE0PgVnBjU7Og0eRyquHYuouTYC0gCbQORjCF9LaduNNx3z
 OokvvkQ4VPthxcvNOGAkS0JpX+HKWYNUvl8u5xGUpXnjBEnlgNLbZDGUHGk5YHXYpAUahF0c
 zHM3uzan7Rb3VbPfzw4En2UhbhRgpEHuRZryl4eJg3Qyoac36Fpg0dcoWYtUwBY7hRbyOYsa
 GVmMktCI6/RrTplgc50WX+hRlNaDxqD902tkFYEmQU1laVzurAh8YH8BQqMwKzd22dMJjEep
 OnAljfrCWysZNnx2TAuVEIjoPvmJTC0Gssuh+j/d/lp3bFjCdYmvkNqTW0SohDjDIU6g0ivS
 SxC4rNrcaOiXcIPi/RTNmRZvIj8jDiDPmVJRfwn96QMdY0ZlPdexhDWQ32MlghxyzAmPKN25
 wGC5i6Cavhm6Buzkw==
IronPort-HdrOrdr: A9a23:2X6r4a1dQYhIYdoGaWNY+AqjBKckLtp133Aq2lEZdPU1SK2lfq
 +V7ZcmPHPP4wr5O0tPpTnjAsW9qBrnnPZICO8qV4tKNzOIhILHFuxfxLqn6TvmBiX166p82M
 5bE5RDNA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,224,1643670000"; 
   d="scan'208";a="29247704"
X-MGA-submission: =?us-ascii?q?MDFsA9G3ZKQoAF0BZbWhPRga3plE+0pBQSx+Zd?=
 =?us-ascii?q?YJw5IndGI9BuaoguMut9ox+m1mf937ZizrdJHWLXpGrE3jr4tYHWubb9?=
 =?us-ascii?q?FobA3wWr/rFk9acIRjXIi3R6r7k2v9H+e6naAerLF3vyRmIrx4cjJssD?=
 =?us-ascii?q?Y+kSqZ0x9XFxBXaN1qh3ZTFA=3D=3D?=
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 10:14:30 +0200
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V4e0bb030419;
	Thu, 31 Mar 2022 08:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=oX1YHHz64X01rWaYta9PxOZA+Y+SF6YtCioIoccBc88=;
 b=fYOeXyNSnMVKirKQoKM07WPB4ThZ/5GPksyMhF4yeOEFMSxYZqOQQhPwbvWcnKPtB8EP
 4UE+afi5lMHHQ5DJcROl4TWbZ/UlPr5uGUprul5zFVmYEekttyO6rLlekuYSCqlijgi6
 rkoqdKyDcwBwIBIy2dK+pdxF0EaIpvaeBXHaHOThHPMXQDsO7dqWv5RuKLcHWkNU+apa
 92IjMUlzeuh8AuF8cX0R9pT2jElekB63p2NyMhyq+uSUKbaLf93amA3Q3dM72/ryDQYq
 gamUTFZcY2febbxzbUjcD8jN9ZCljZ9YwCwGUZzhl4wB0zLf68mOykmx3w7BHrschznX 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0kmhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Mar 2022 08:14:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22V8BJrv026171;
	Thu, 31 Mar 2022 08:14:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s94g9rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Mar 2022 08:14:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TflrrQO+sl4hlwUCCl5UsUnUpyreUDtIwFihLkTjM4uz9keJ3hHRRsXhuaVW6s50dp13xQvvcpWiDkNSwKyxkIVPfHXBPnWB2oVhwqaUkvPMTuQnln7coxPnjvmMTAZ8npISLXxW4SPQAOHqC0bwgUmlbdmxi9qj5rcQgQqd1TvAdW15PWY2WBniLa0ZtQm8quO9DO1dJ1+/1DjoT39eQtx4Qn3Tiskf5XBM4cwovIVAgiIIb7xm+yaWQT/HylJ7qOPKRKU+rVV9mC7+yJkkOeuqiri6Yt8TTO/H64t/djShGimzih9RZw4EV2ACoZMI+FNiVAKWeS+VOS4llAjujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX1YHHz64X01rWaYta9PxOZA+Y+SF6YtCioIoccBc88=;
 b=G+XPdjT0N9oCLsSbJSJ7W04f5GJ6EZZDelWX3Ro9PYNQ67NeWZPIusMSBmRAR9gryruoyf2b+XuKQyk2VuPkLB/NlsnKJYNHfgMCI0gI12Pm6MXoVdIMJtQnJtF+PtYJCWpPhtXyPhQ/4nicia3mlf/IBqb3hyDoAmizJvWgv0/vacFf6HuuCWKGl3ipe5c/MUeW3YSfFl0oBU7vYscLJtI0ektzOKPWDtBPzoOZqf8zsRlWF5kFZ39JtNK0+fqdCUnr3RBPnh7O62ZJPMTPVinlRJScwu1Dsp+CRLZ2Dq4knhLBzFiIadJstfE8YYeM2Vi0T4BfOV735uIy+16kdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX1YHHz64X01rWaYta9PxOZA+Y+SF6YtCioIoccBc88=;
 b=pdxM2Pg8k1PXxwNU8QW1zycqIT+gMB37hiZQuSHL+01nNZe0qz4b5agU+11/4ZhTblWlexg2dqywSwueExwnvsx+SE3In0izgT6RT2HNY8xs9HSAoMfzsfZJj4vPL7xoAKYF2HOpZEEnwDs9qnvl63neYW74AQLBER49Px3taQw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3508.namprd10.prod.outlook.com
 (2603:10b6:408:ae::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.20; Thu, 31 Mar
 2022 08:14:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 08:14:22 +0000
Date: Thu, 31 Mar 2022 11:14:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: David Gow <davidgow@google.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-sparse@vger.kernel.org, cocci@inria.fr, smatch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, julia.lawall@inria.fr
Message-ID: <20220331081409.GY12805@kadam>
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
 <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
 <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0099.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa49396f-e3b7-4d41-9416-08da12ee7632
X-MS-TrafficTypeDiagnostic: BN8PR10MB3508:EE_
X-Microsoft-Antispam-PRVS: 
	<BN8PR10MB3508FDEE7612F9ED9DF5F4778EE19@BN8PR10MB3508.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vZAhi1ZLinwFEoI48C33dpXnFXPITxP2Uz/jYKTQSov08wM6tkUFqsG0isTBafC0q1Dq+LtVqeoDXlDrcH4mKaktdnymHbBboyLuUPKgnfdHip7M9AewtxNucdq20ge7EKrnXh1SI2YNJ0b4gj3l7w8oSGQYB/siN29bGGmyg9kqU3KEqCg0TSmgsQ7tMcGxuKW5kX0bzm7U4V4uwdMdNjiysSvo7Chj52HR+Na7GguSlfwtsjo+9VVryuRCmpPGWsu3e72PWxUVHdMxWy9ULh0EBg5CJTq2ax3EqBzUQsQxjV41GvdCWk2CoI+xYEsu12HrBdaCIbhXEeW2JNykViyVQONVJp+nDwpxNxVZCp/oIVw1IqAfkV6CVehdjsUp4glu1KFUIjVq18ONIgtzTrcHYLJsYi6yzB8fs+5d0z6QiRq4NSE1VMUYF+WUOtsj+TbW1jRs5heTaaiRW85u1TW+xBRVkW91Ou4GSn8vX9uqQll/IKgpod16bxP7g7DTIKG1/1/tpzP0zJvc3KJugWg/R28Hjci6DtSzKgZheqCxYK3hYl28Th4aV25NNbWgYm9jORQV8J+91Q24dXLhsFM7yYWtNsOWpi9bfwU4LfLsGayb7fFDBvBNbSM+YrbhTPyotz0sIf4Rzwl1E6kJBhzTz7m1MfJ9Uxe4/jL/ed1Qymscj2zGaxIjSOlL1/dasTk+pCrW9YSLubYDLb3DWw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(2906002)(186003)(26005)(52116002)(6512007)(9686003)(1076003)(33716001)(83380400001)(8936002)(6486002)(6916009)(66476007)(38350700002)(38100700002)(7416002)(5660300002)(86362001)(66556008)(66946007)(4326008)(44832011)(8676002)(54906003)(6666004)(316002)(508600001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2wqaQw5/ep0g1M3lTV6HpEqNIbTqVnFtxi20+338QMilbWymwfai/joWnXT6?=
 =?us-ascii?Q?zIeZYNYfY2yzupqbrbtDZaalXM4ObXhF7RSSop37gLOFBCOYEURlqaC9T9AS?=
 =?us-ascii?Q?3DR9YzkXJCeOsNAMO73hFKtHZIDwo5FXJQFgMdDm/iBvGEvMcY5s4k29MZTR?=
 =?us-ascii?Q?RMEIe5xO7rlxO3xRo8HMLpI+qN5WvRMdFdRfLx+nBv0uR6qMrBd7nAlNG6zN?=
 =?us-ascii?Q?lME1v95IUPvH4MB13aXpccuGgaALFfbFR1EYfZB8YjciePbPTwSP2pcXQwfR?=
 =?us-ascii?Q?xBQjhXvYabL/gb5fpTFReDtKEQ9B+hW9L5QRct17tABqYZhlLupj1PJuvcAw?=
 =?us-ascii?Q?oS3RRA1/RsaPq5TyvGI89XW76BbgXha2aH48pSP1w/zt4UqKFqUoysFElFKl?=
 =?us-ascii?Q?7Bsa+hFdbHmTOGD8Ex6p/vx6CZuFU1wMthFOyD9ILnjxDwbWIWyV5GDaMp6z?=
 =?us-ascii?Q?/mIL5CyG94CipPqGbF/D7Tqn5kYl1P+D/39mLbdr0elfZkaaHnv8uXWXx72W?=
 =?us-ascii?Q?l+CLSKse96zZrC1XQVTTYv9dAvi1dqtyRnVxEN5fPrWT0VYDQC9O9ojieq9z?=
 =?us-ascii?Q?5eZ11VEOO8L72OXvk6/OpvSh2rxKYvOSfRSpymSXQYEs/24tElLWT8B6lSDp?=
 =?us-ascii?Q?gBdwQZL4dMcWvoIaPTkVegIw/cYoIUuKj6l7BR2tbL9nC/OTTena981mv88Y?=
 =?us-ascii?Q?ZPc5S1JUXySho9CEgQUPx5QiBeshIhzmwUU/BOAJpfjZY4EPWubWu1DTZKCN?=
 =?us-ascii?Q?3KvO45c7DF83mOjgSQoLcrI5oHhEqTBm5t6kSoBzMzE3jQ+LOfLq+14ArHqh?=
 =?us-ascii?Q?9LJ3OcB+IOarp9ifrtDqS2an83EYtaSD5WUlPIepNDiJlT3EgHbixzSyYFKG?=
 =?us-ascii?Q?BBxSQGi5JSyJHbrAsTr9VBzu5yuxp+fkK6TiTQGC8JMxS+mduV2AqfRN1yaS?=
 =?us-ascii?Q?Gx3J8k66RBobv+79U250klXZX56hmOxb05HxsjIRcJwvifOZQIV1D8coY8LW?=
 =?us-ascii?Q?4vqQk/V/aVRs3LwuMP+5Zso4qc/uBswqUUVfskOytzFgu6AqQKJm5KDAa7wM?=
 =?us-ascii?Q?4kTfVXqmpUTYrkjpuwPsbEsYQOY8Ic2qu/hLUvCVD2eVHzOvWL7RoIUacMNj?=
 =?us-ascii?Q?/D/JcZhjQE1qFkn1NdWC9DLSWZuM1zNftE+zKBiZYjHxsT6a7mZ5Jvr8SBcT?=
 =?us-ascii?Q?n5z3eSTSsYALB0FsQMEiMgGJMzYreRAADiKsBcgMUVugTqEcD4l3QtzQzBN7?=
 =?us-ascii?Q?J2X6FJ8MZ6xwPnTDchxLg85edFmbzCrxvEH/tVI4UXx28WkloM5ALAuYrPCI?=
 =?us-ascii?Q?NJI4M9qP+vp7fMz0/tZayXEjYdrG+S4ZcSWyX8YcjD/jU9aznrIO3Yc0udpN?=
 =?us-ascii?Q?zJ4TMvWm950kgeLTW+exQ+uzMMfQHYcHpzRHxN1JQxKwqVBgbgdxzwDLlBRb?=
 =?us-ascii?Q?wAEcp/ZhrS/ltg2JpkEZKrh7gqc+0piOCG5JltlqtJGOo1fxrrNxK1TcWKhH?=
 =?us-ascii?Q?yRmnBLDsvBSzpkTJYaVTDFfX0rYchj8d0gXiYUcBAoNUSrOTYuXKAcdCBDJZ?=
 =?us-ascii?Q?WU4o55LlGhenJKUn7U1DRjQX7JaTldXwdcM5NckZhBxOxafEEzEUPtzeoRGK?=
 =?us-ascii?Q?ahNlVsCmYSVd5MrvpG9ivukBQ2js8uU0nXlcpqbLUGnKS2kGWw/CWus4eEvm?=
 =?us-ascii?Q?J7xLsKSA/eNSHMOep67a8KOgidMD5xyR0BkQ34JhwjzQXEAabIbxVxbhQBpP?=
 =?us-ascii?Q?IGeUMzQlZYWutEhx0Isrpn/6SyOU/OI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa49396f-e3b7-4d41-9416-08da12ee7632
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 08:14:22.4326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbxbJbjzcG81nOYdorxr2rFcLqiya/PWssueqPKYkW/mvHdnRYfzqIyqRMyqujSuTlXahvyg+6zr6NadDEVGFNQ2fihXCD7lQLxE5UIguQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3508
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_03:2022-03-29,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310045
X-Proofpoint-ORIG-GUID: qHsypwRQde9I_185KKpu-b7QVC0_Zfn0
X-Proofpoint-GUID: qHsypwRQde9I_185KKpu-b7QVC0_Zfn0
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 2/2] Documentation: dev-tools: Enhance static
 analysis section with discussion
Reply-To: Dan Carpenter <dan.carpenter@oracle.com>
X-Loop: cocci@inria.fr
X-Sequence: 322
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/20220331081409.GY12805%40kadam>

On Wed, Mar 30, 2022 at 10:48:13AM +0800, David Gow wrote:
> > +
> > +Smatch does flow analysis and, if allowed to build the function database, it
> > +also does cross function analysis. Smatch tries to answer questions like where
> > +is this buffer allocated? How big is it? Can this index be controlled by the
> > +user? Is this variable larger than that variable?
> > +
> > +It's generally easier to write checks in Smatch than it is to write checks in
> > +Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks
> > +because there is no reason for re-implementing Sparse's check in Smatch.
> 
> This last sentence isn't totally clear to me. Should this "because" be "so"?
> 

I stopped reading your email when you wrote "Cheers, David" but I should
have scrolled down.

There is not very much overlap between Sparse and Smatch.  Both have a
warning for if (!x & y).  That is a tiny thing.  The big overlap is when
it comes to the locking checks.  The Smatch check for locking is
honestly way better and more capable.

I always run both Sparse and Smatch on my patches.  I should run
Coccinelle as well, but I'm more familiar with Sparse and Smatch.

regards,
dan carpenter

