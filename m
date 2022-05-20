Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815C2C433EF
	for <cocci@archiver.kernel.org>; Fri, 20 May 2022 14:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6yx6kFopzvGFRgFkw/yqCrMnPgSrVKtaDm1gPawMkM0=;
  b=QRliAQFVdVpmPYCwO8cuS47uuWLWqKJU9uSN29By5EjCqvV0RHvwxnGd
   2qzPEisoVqOj5i4uWdvIn4sbMGUAIFy15z+DMfRKwopIBtNlGCM6oavdE
   ipdGSsu9LDP6O6lykeMqsPXHxLYJyue8lvam2v6L0Iam4xCRVllmBpQXd
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@renesas.com
X-IronPort-AV: E=Sophos;i="5.91,239,1647298800"; 
   d="scan'208";a="37357883"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 May 2022 16:00:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 45F2AE0094; Fri, 20 May 2022 16:00:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0CDFBE0094
	for <cocci@sympa.inria.fr>; Fri, 20 May 2022 15:57:18 +0200 (CEST)
IronPort-SDR: rm4TniXpf/3WAhEKRwJBsPe3Xz5WSkFrdEmZfdasdrkqQDApAp0AcfdzCfKHT+2ODel7wmoS7E
 YFykxJuzVBIVpskWiOJUBpg9WvHoUUQ68b+tRVbw9bf3BsRHTJq+QiKhhxCCxDYjyd9W1M4YbB
 mPaTHCrHg/UX5sY7LGeYyA2pU2iFym4uJWDl9aCo7w1V/kuS2TALIdb4xX2eJqhEUE4YVikAXE
 1CzCfYclYoLaUVPMF1ZwWwtLNLcokBwpvi8kdAtQlCLFn7bRnImUKd4Hh+RWCNpnnPJMDUNV0t
 OnwDuhEtG73bwXk0TvTLgflL
X-IPAS-Result: =?us-ascii?q?A0BHAQBUnYdih3xxayhagQmBT4FSUnxYLAcIQ4ROg0wDh?=
 =?us-ascii?q?TGFC4MCA5cUhVCBfAsBAwELAkIEAQGFAgIWhSofBgEEMgcOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQELDQkFCAoHDhAFQWSBAwGBTgGBW?=
 =?us-ascii?q?AYDATANgjUpAYNjAQEBAQMSEREMAQE3AQ8CAQgYAgIfBwICAjAVEAIEAQ0NG?=
 =?us-ascii?q?oJbgxkCn10BgT4CAoodeoExgQGCCAEBBgQEhgGBXAmBECyHP4JaOIQSN4FVR?=
 =?us-ascii?q?IEVQ4I3MD6BD4J8O4NUN4IulUsdOwNONRKBIXEBCAYGBwoFMgYCDBgUBAITE?=
 =?us-ascii?q?k0GHQITDAoGFg5CEhkMDwMSAxEBBwILEggVLAgDAgMIAwIDIwsCAxgJBwoDH?=
 =?us-ascii?q?QgKHBIQFAIEEx8LCAMaHy0JAgQOA0UICwoDEQQDExgLFggQBAYDCS8NKAsDB?=
 =?us-ascii?q?Q8PAQYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EHAcdAwMFJgMCAhsHAgIDAgYXB?=
 =?us-ascii?q?gICGVgKKA0IBAgEGAQeJRMFAgcxBQQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIA?=
 =?us-ascii?q?ggnGwcWNhkBBV0GCwkiFgYsCwYFBhYDJCcqJwUaBQQfARuXU3obgjc7KZIRg?=
 =?us-ascii?q?1mYBpJJNAeDUIE9BgyeWhWoWS2RDIUuIKZkAgQCBAUCDgEBBoFoC4IDTSODO?=
 =?us-ascii?q?E4BAgECAQwBAgIBAgECAQEBCQEBAQGONh6DO4peQjM7AgYBCgEBAwmOAYJIA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:tgepJBGH7OGTkA7Y22+I5Z1Gf+REhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k31xmXBs6FtbptsKn/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uys9ZDfeQRFiTSybb5zL
 Ri9sBncuNQRjYZ+MKg61wHHomFPe+RYxGNoIUyckhPh7cqu/5Bt7jpdtes5+8FPTav1caI4T
 adFDDs9KGA6+NfrtRjYQgSR4HYXT3gbnQBJAwjB6xH6Q4vxvy7nvedzxCWWIcv7Rq0vVD+88
 6lkVgPniCYfNz447m7XjNBwjLlGqx6lvhBz3pLYbJ2QOPd4Y6jTf84VRXBZU8hRSSJMHJ6yb
 5cBAeQCM+ZXrZXyqVQBohalGQmjH//jxiNUinPq36A31fkqHwHc3AwnGtIDqG7arNX0NKcWT
 Ou7w7THzDvEb/NMxTf96IjJeQ0mrPGUXbJwcM7RxVMxGAzYgFSQrpblPy+V1uUNqGWb9fRvV
 eSxhG48sQ5xuSKjydsrionMn48YzE3P+iplzogvP9K4VFJ7bsC+EJtWryyXK5Z6Tt8tTW10u
 ys31KALt5G7ciUX1Zkr2QDTZvOGfoWU/x7uUOScLCt3iX9hZr+yhhi//Euix+HiSsS51FZHo
 yxYmdfPrnAAzxPe5tSdRvdg4kus2yyD2x3O5uxKO0w4iLTXJpE5zrIul5cfrUrOEyrrlEnqi
 KKbd0Ap9+e05+j7Z7jpu4GTOopxhw3jL6gjnNG0D/4iPQgURWeb/Pyx1L398k39R7VHlvk4n
 LPBvpzGOMgXv7e3DRJJ3oo67BawFCmp3M4fnXkaMFJKYxWHj5XvO17TOvz4Fe2/g1OwkDh12
 //GIrzhApLLLnTZl7fhYKp960pbyAo0ztBT/Y5bCrYEIP7rW0/xssLXDgMhPgG73+rrEshx2
 p8cVG6VH6OVLa3fvUWV6u4xLOSAfIoVtyz8K/gh6f7ul3g5mVoFcKmx3ZsXaXS4Eu54LEqEb
 3vshc0BEXsKvgs+V+HqkkONUThNaHapRa08/Ss3B56hDYfGXoythqeO0z+hHpJKfmBGFkyME
 XDweomaQ/sMcj6dItd9kjwYUrisU5Mu1RayuwDmyrpqNfHU+y0dtZL7ztd5/ezTlRco9Tx1F
 cuRyW+NT3tskmMSWzA2xLx/oVB6ylqb1ah3mfJZGsZX5/NNSQo7NJ/cz+lhBNDoQA3NZNaJS
 FC8QtWnGz49VNwxw8VdK3p6TvCrlBPexGKHB7EPlrqETMgR+7jfwmO3CsJz0XfA24E+glNgT
 sYZcSXsgq956hiWDIrKu1uWmrzsdqkG2iPJsmCZwiDG6EVZVhNgFK7BXlgBaUbM69f0/EXPS
 /mpE7txdkMLwsmJIapia9vzjFwASu2pcIDVZGm6mk+xAwyJz/WCdty5VX8a2XDlCEkA2y0f4
 nGcKQgvTnO5o2PaSjFiClX1f0P92fNzrn6gR1RyxAaPOR4yn4Gp8wIY0KTPA8gY2agJ7WJ48
 20c9DeV2tvXD4HFvA99ZOBHZst75l5b1GXfvgg7P5q6LqkkiERNOx9vsRbI0BN6Qp5FjdBst
 GkjmRJyKKbe3V9ecCmE3YHYILDRJ3L751akbKuFkkrG3oOu87wUoO89t02luQioEkQ49HAyy
 9lU1z2R6orNFhYSQLrrX0A67BFh4brdZ3p1/JvagEVlKrL8qTrew5QpCe8inw6nZMtaObiYG
 RXaMfU8X5HrD9dy3l+jY1QDIfxY87MyM4W+bfya1aW3PeFm2jW7kWBA54M72UWJn8ZlYsjP2
 ZtNg/SR3w/cEiz5kE/kqcfv34ZNeTAVGGO7jyniHo9YIKNoL84NDi+1Lsu7y88b5dalUmNE9
 FOlG1IN2dO4MRuUYVvn2ARM1EMR6XW5kCq8xjZwnnkntK2alCDJxu3jclIANAspDCF6jVboZ
 4W4kNcAQEi5RxIkkha+7F28zK9e5ex+I2TVXUZUbn3uNWgxN8n4/rGGYsNJ9NYpqXALCKLlO
 Q/cE+em5UJAj3CGfSMW3j0wejC0t4+smhV7jDnYN3NvtD/Cftk2wx7D5dvaTPoX3zwcRSA+h
 yOEYzr0d9Sv49iQkI/O9+6kUGf0HIVTcC2twI+fszGn5XxCGxC5kuu6gZvsFg1wgkqZn5F6E
 D7FqhrxeNyhz6S7NaRqclZvHkP8+uJgF4dziYIrwpoX3DJJ4/fdtWpCmmD1P9JB3Kv4Z3dYX
 j8Hzene5w390VFiJHaEr27gfk2U2dApJ9yzY2dNnzk489gPE6CMqrpNgSpypFO86wPXe/l02
 DkHm7Mi73sTgudBvwRIrG3VGrATGQ9VMTPrjQiI/vikoaNaf2+0N7O30QJykMugA7eLvgxHE
 CqhPM56Qmkpt545aQiQmHToj+OsMMHdd9cSqgGZn1/bgu5ZJYhw3vsGiCx7OH7s6Hgsyuo1l
 xtrjvTY9MCML2Rg+r78AwYNamWzPptMvGi01uAHxJrFuuLnVo9sETgKQpbyGPehETZJ8O/iK
 x7LCzok7HGSBbvYGwabrkZgtXPGVZ6xZBT1bDEUy8tvQB6FKQlRmgcRCX8inp89UA2m28v7b
 Edozioc4FPjowAKweVtfUqaMC+XtEKzZzE4RYLKZgJW7wUE6kvKNtaC7vNbBSxe84aot0qGL
 WnRNGEqRSkZH0eDAV7kJLyn49LNpvOZCuSJJPzLebySqOZaWqTA1de134Bh5TrJKtSXMywoE
 aggwkQaFyMceYyRi3AVRicQjS6Ic8OLuEL25Hhsts7muPXzBFCzvc3eUf0Kd40ook3+gL/fZ
 bLIwn8hdnAAkMtLnCGtqvBX3UZO2Xw0MWD1SfJY83aKFf6Ym7cLXUdDN2Uva40Qqfp7h1YFO
 NaF2In8jucq16dsWVkZDQSzyIb1Naloaym8LA2VXk/TbebffGSZzZ2vOvHuDuEAxORSvBmtt
 TvJCFftMnKbjT71WhuzMOZKyiaGIBhZv4L7eRFobAqrBJfvbhnxWDNupQU/2qZ8xnbDNGpHd
 CN5b1sItbqIqyVRnvR4HWVFqHtjN+iN3SiDvaHULZMfsP0jBSoR9aoS+HMh175c9z1JXtRXo
 A2K95tJmAnjleOCjD16TBBJtzBHwpqRullvMrnY8Z8GXmvY+BUK7iObDBFvxZMtBtD0uq9Ww
 8TCj+qvcHEbq42SpJJHQZGOdIqOKzI5PADsGSLIAQdNVjOtOWzFxgRcnPyU6nyJv806p5zry
 /9sAvdQUF04EO9fC1wwQIREec8oGGp9yvjC1pJbgBj25APcT8hboJ3dA/ebAPG0bS2ckaEBf
 BwQh7XxMYUUMIT/nU1kcFhz2orQSC+yFZhApDNsaggsrQBD6n97Gycr20PhLA6h/3gJCf6lt
 gQ7jAZlaP9r/zDpqQRSRBKCtG4rnU89lM+wyyiWayL0JbysUJt+KRLS7xF0FaijBgF/YEu1g
 FBuMyrCS/RJlbx8eGt3iQja/5xSBfpbSq4CaxgVj6LyBb1gwRFXrSOpwlVC7O3OBM55lQckR
 pWrqmpJxwNpaNNmbbyVPqdCyUJcw76fpiL9nP5k2xcQfgxelQHaMD5NokEDMaMqYjal7vA5o
 xLXgCNNISANT6Z4/qospxl7Y6LYiHu9m79bdhLtb6rGd/zf4y6Y0pfWJzF4nkIQyxsYp/4vi
 Z9lKwzMEBlzhLqJS0ZQbZaEdV4TN4wKsyGMNSeW77eXyMosbdzkT7LmEbfW5vRT3hLBfk5hH
 pxSvJ4IRsD+iRiBf8m7dOVXm1JxtEzqIl6BEfhEKgmTnjtBu9u40JJ8wYhaIHcaHHl5NiK0o
 L3Qo2pIyLLGVdMyKB/yu6MeO3Q7Q8Sh3SVeuiYYZNFW+sAh7lDbqhjH/mHXBjS6aMd/bvCJY
 x8qEMux5Tg076mxjxjQ74naIGb5c99lv42WgQv1j4yKDf5PRKI7uEDZydAweg==
IronPort-Data: A9a23:hxinmqCNBwR/IxVW/+7mw5YqxClBgxIJ4kV8jS/XYbTApG933zUBy
 TAcW2CFOPeJamf2LoxzYNi38k5S7ZLVndc2OVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EnkZqTRMFWFw0HqPp8Zj2tQy2YXjW1vU0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYowzSvvNd8
 IV8jKehSS4UMonow+VCaSANRkmSPYUekFPGCVqHl5TKimr9Kz7ryfgoC1wqN4oF/OoxGXtJ6
 fETNDEKaFaEmv6yx7W4DOJrg6zPLuG3ZMVG4i4mlGiCS698HfgvQI2SjTNc9C8wh8QIEPrBY
 NAFaStHdhnGbgZGIREcD5dWcOKA3yWhLWwD9gj9Sawf/2jsyRZ41uPRG/XPa/Gma8p7wne7n
 zeTl4j+KkpDb4fAodafyVqngeTEnAvgSYcKHfu58ORriRud3AQ7DBQJXF+/ieu4j0SkUpReL
 VYV82wgt8APGFeDS9D8W1i/uyaGphhEAt1WSbRgtEeK17be5BufCi4cVDldZdc6tcgwAzs3y
 luOmNCvDjtq2FGIdZ6D3o7PjBCeAXgkFFQTZQY5QS8huNi8mrhm23ojUe1fOKKyi9T0HxT5z
 DaLsDUyit0vYSgjh/rTEbfv02zEm3TZcuImzl6LADP5s2uVcKb8PNH1sQKChRpVBNzBJmRtq
 kTojOC81Iji57mqjyWOSY3h95n0u63AaGWC2zaD87GMEy+k+HfLQGy9yDR3JUMsNd1ceyfvO
 BbUv1kIvsMVO2a2Z6hqZY73E94t0aXrCdXiULbTc8ZKZZ9yMgSA+UmChHJ8PUiwwSDAcolmZ
 f93lPpA615BWMyLKxLtF48gPUcDnHxW+I8qbcmTI+6b+bSffmWJbrwOLUGDaOs0hIvd/liPo
 4cPaZHUlEsGOAEbXsUx2d5DRbztBShrba0aV+QLLIZv3yI6RTpwUqSPmdvNhaQ/wf4Pzb6gE
 o6Btr9wkwOk3iKvxfSib3FocrT0Wphj5Xk8JzQrJ1+02n8lCbtDH49OH6bbiYIPrbQ5pdYtF
 6dtU5zZXpxnF2qbkxxAM8iVhNEzLHyD2FPVVwL4MWhXV8A6G2ThpIS+FiOxr3ZmM8ZCnZBjy
 1FW/liHGsVrqsULJJq+Vc9DOHvq5ihByLwoDhSUSjSREW21mLVXx+XKpqdfC6kxxd/rmlN2D
 i6aXkUVo/fjuYgw/IWbjKyItd7wQfFzGEdBFnKd5rGzbHGI8m2myI5GceCJYTGEDDivo/j6P
 bwKwqGuKuADkXZLr5F4T+Rhw5Uh6oa9vLRd1AllQinGNgz5FrN6L3Ca9sBTrakRlKRBsA67V
 xvXqNlXMLmEIu3/F1sVKFZ3Z+iPz6hNyCPf6/kuKV687yhypeLVXUJXNhiKqSpcMLosaNh+m
 rp54JdJ5lXm2BQwM9uAgiRFzEi2LyQNA/c9q5UXII73kQ53mFtMVoPRV33t65aVZtQSbkRze
 m2IhLDPjqh3z1bZdyZhDmDE2OdQiMhcuB1Oy1NedV2FlsCZ260V5DsJqHEQdVwQyR9KleVuJ
 mJsKkt5Y72U+Ctlj9RCWGbqHBxdABqe+Qr6zF5QzD/VSEyhV2rsKmwhOLnSoxlJqT4EJjULr
 quFzGvFUCrxeJ6j0yY3X3ljoaOxQNF08DrEh836Td+OGIM3YGa+j6LyN3AErQDrXZE4iEHd+
 LA4+e9xbej8LnYSu6tjUo6cj+1KFFaDOXBIRuxn8OURB2bAdTqu2D+IbUesZsdKIP+M+ki9U
 pQ8KsVKXhW49SCPsjFEWvFVc+UoxKYktIgYZ7fmBW8aqL/A/DdktZTn8CKh1mImRtNZl9kwd
 9HKfDWYH23M3nZZlgchdiWf1rZUtTXFWOH94Axx2McxMcpa9cZXKQQ12LbyuGiJOgx6+R7Sp
 BnEe6Ld0+1lz8JrgpfoFaJAQQ6zLLsfkcyWpRurvY0mgcznaK/zW8E98zEL/Di6+ZMLVtJ6j
 r2W9tXw2SspeZ4oBnvBlcDp+7ZhvK2PsSk+Di4zBGNXmyaZUdSq6BwGk4x9xVqlj/sFjvSaq
 8CEhAdcuDLbtxqxBJGYVsSGLysgNg==
IronPort-HdrOrdr: A9a23:2yACxK3gXXBbPRApOzIoJQqjBTRyeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ4uxpOMG7MBDhHO1OkPMs1NCZLUPbUQqTXcpfBO7ZrwEIdBeOkdK1uZ
 0AT0E6MqyJMbEYt7e23ODbKadH/DDvysnB6onjJjVWPHhXgspbnmVE43OgYylLrX59dP8E/f
 SnhvZvln6FQzA6f867Dn4KU6zovNvQjq/rZhYAGloO9BSOpSnA0s+0LzGomjMlFx9fy7Yr9m
 bI1ybj4L+4jv29whjAk0fO8pVtnsf7wNcrPr3DtiFVEESstu+bXvUjZ1SwhkF2nAhp0idurD
 D4mWZhAy200QKUQoj6m2qr5+Cq6kdS15ar8y7lvZKkm720eNtyMbs/uatJNhTe8EYup9d6ze
 ZC2H+YrYNeCVfakD36/MWgbWAdqqOYmwtXrQcotQ0pbWLeUs4jkaUPuEdOVJsQFiPz744qVO
 FoEcHH/f5TNVeXdWrQsGVjyMGlGi1bJGbPfmES/siOlzRGlnFwyEUVgMQZg3cb7Zo4D51J/f
 7NPKhknKxHCsUWcaV+DuEcRtbfMB2FfTvcdGaJZVj3HqAOPHzA75bx/bUu/emvPIcFyZMj8a
 6xJW+wdVRCCX4GJff+raGjqCq9PllVdQ6duv1j2w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,239,1647298800"; 
   d="scan'208";a="14669362"
X-MGA-submission: =?us-ascii?q?MDGytjBIddGHlX63VzgvUIJfJ4NMW3rnQ9g5if?=
 =?us-ascii?q?hf0sC0xorCsfzFbr0HHpw0QvFQarag8FPqXoNVO3Voa+ApYW80iPel8U?=
 =?us-ascii?q?WIL67LnY0EF1ARLXVMucv2aFfSdHnl4X+hIzRM+cdIUrldgK1VaOgqaS?=
 =?us-ascii?q?DbAPceTZvjRyjC4XPcVf7Frw=3D=3D?=
Received: from mail-os0jpn01on2124.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([40.107.113.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 15:57:14 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4+yQynyWW2GaSpoSJmz+n7VYpTh6WVheJEot9336LbZV3IXrfOo48z56b5fsP4TZ5jN9vyoHSwF7H4ySuPx+Mgi1urXMleLw0CPsfpln2Qz5Dqxm/uhI1tjJKhctrcTFaVCq0oDlf7xHJVKkRqukqNuiJATJRAd+uCgKFV5MxkIq8GDsZ8KNmFwQOrE8kT8owxywKWN/IaNC6R5P8u77y8CfXuBm9gnZFABGXCAFcc6Xo52SFqA68bK4UuK7j03z90plqHoTdksCGTtKZK89vs6CK64xAJodCge2Glb7JloPC6j/vbWUKdCayZ/qjvpDKOuZU5XtFDjXrv6G1HVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yx6kFopzvGFRgFkw/yqCrMnPgSrVKtaDm1gPawMkM0=;
 b=elkSmtv1dfOKg9uFD2GtuJQgWATtMMmIhj4UySSHAXneEwe9aq6v08AOo8T3XvdIB+3hSqIk7sO9iGpY5lB3omw00bsMZ0csZXl2L23uizI0UoaD3sBErH8H5Z1a5giB0ds6AcOBJhXQyWLp7JVVqVnAHqRSOtYQPwUCh0xRcSo3DZ8MZlDUjvOYss1lh4TuIB6lfdjSxklINmdaOPlNl47fpAeJ2NZOmxX7wq5uXBuFyAeHhSr/NOqGjT5tufLbTBo68hjd+vMONEANkwc72YONS10Cb9/yycZ30Ww5Et+Nv7Z4f1Aj/QLyRba6Tjet/tqDMWCFPQZjvMC4cdgN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yx6kFopzvGFRgFkw/yqCrMnPgSrVKtaDm1gPawMkM0=;
 b=fMQVjbHkVALcScN7wd0AvVZQijHsn/UpA+n0P+lQFnCoiIv7TwoS56Tstv5lS1cNYIKfEnSsiW27Eu2fS1y/vLU3Sw1kJ4ZGXPE3jBh/LnKF3RkGHciO2qYmZevcqIYR1JUqka/Gn2tc4wrijkuxAqMszh/gSjh0pJlluqxm2Qs=
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com (2603:1096:400:de::11)
 by TYCPR01MB10102.jpnprd01.prod.outlook.com (2603:1096:400:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Fri, 20 May
 2022 13:57:09 +0000
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::e180:5c8b:8ddf:7244]) by TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::e180:5c8b:8ddf:7244%8]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 13:57:09 +0000
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
CC: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>
Thread-Topic: [cocci] [RFC] coccinelle: Add test for unnecessary check before
 calling clk_disable_unprepare()
Thread-Index: AQHYafMQ1GqDaGPIYUKMw5zLbxeQC60mn8+AgAEtr7A=
Date: Fri, 20 May 2022 13:57:08 +0000
Message-ID:
 <TYYPR01MB7086773272C8B95C344E663FF5D39@TYYPR01MB7086.jpnprd01.prod.outlook.com>
References: <20220517133556.6934-1-phil.edworthy@renesas.com>
 <c1d5d00d-d770-530b-abfa-0c1f462e5f22@web.de>
In-Reply-To: <c1d5d00d-d770-530b-abfa-0c1f462e5f22@web.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8c568e8-8b0d-41dc-f809-08da3a68a1b6
x-ms-traffictypediagnostic: TYCPR01MB10102:EE_
x-microsoft-antispam-prvs:
 <TYCPR01MB10102F3F9C3132EA1217D248EF5D39@TYCPR01MB10102.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xLO26TM8nq1uD6ZS19LonYGxmO6A34zA9wp+8nqVNvP8bTWx8+D16gGzTM+UL3+Xh8PTX5vVs3drAYW0lmbWhtbueC+glyLaXdRkQSG0DTEaUZPNYu/6bEvgKxjNKlOtwV7Lweh6DoHYZ9aGnIqt2bdAe36knN+pLW5f13xRlX2a0BJpaHiqiM+5HJVHIG56A9NufN2g+rB9/8/Z4i8QNP7z7J/o5yQ4g/5YMdqRpvfMYB3Bn8QJCNQQM0dPxvZKELbeS/a1OkFPfqjj3GLhKdl/KvuKZ+whCuTPebxLBBHrBjsW9JutsslQ4O052GSoTAd3G9viCxNDqDbODSpAO+h5zS04AU3zMvAXQfNRrw+TWRisr5fLRuLDlrbsqO6GLAWn3ohvdCHYaLjSe4PMyiyoyaAzXRdHZRXREJjKqWdOjplBGR8W3omGw6PzqkvZVo1yioIZ+HsmxqyA7DAzNs1UhY6PdPcnGeja1zeezLEE3HuErGXm3XZKnbDs4eJ9bGG3RUFj5a2bi9rUpxHzWmhQoPxEuYsnlExL7XBqRnX2fwVeDLjB2U8pwfH9Z3M4YeFrRXPHVtoUBzg02IOCEbbBQ49lFPr9L6zmwzlDFQEReGnAzvi4CglZOznprhDrIufxkn97CddOkhL0T3RscayPbAbSY25sxlrl4N9NtNkbVwQg3A/2QUL1QzmUOitiU9g40tzoJmnMXxkToykDWA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7086.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(7696005)(508600001)(8676002)(66556008)(110136005)(4326008)(44832011)(83380400001)(66446008)(55016003)(66476007)(64756008)(66946007)(76116006)(186003)(38100700002)(2906002)(5660300002)(26005)(33656002)(38070700005)(53546011)(6506007)(8936002)(9686003)(71200400001)(52536014)(86362001)(316002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGFXbnlscW9YTHNYWTczSUpDRzVhSlJnUVlQYTl6MFpLN3UybGJ4ZS9lcGpF?=
 =?utf-8?B?U0JpWGszNThYQlQyTmROOGdjWUNTUVpOWnpmNG05d3g5MTI5T2pDelFJYkNV?=
 =?utf-8?B?RW5rWEpqczlEU2t6YTlrNm1la2RkZVExWDJKeEJaanE1a0ZsMkZCQ2JOd1Fl?=
 =?utf-8?B?NzJsamNoSm9HSFVhN0Y1cVFSOUtTQlY5U2JYNlVuaDZ6dVdrc3BHZEFHOGNZ?=
 =?utf-8?B?R0FsS1diNFYrWEh1SHk2ZHpmenRQNFVWVzlkTnZJcERoN3JOekF6cmtOUC9N?=
 =?utf-8?B?bFhEYVNHS1kyNTFNcGZtbklUb01WdDR0R0pvMGs2cUVBZ2VLVDF1VEUvamIx?=
 =?utf-8?B?VENtY0h5Zjk5bmxvbzNvM1VSKzZmWTJuZDUvdElabExrbjFHLzVsdTJYYkdR?=
 =?utf-8?B?eUlKOHl6ZmpPZGVjZk9kVGZWYy9JRjhSZ1NuZlc5NXAwOFZ5c1ZrZG40T0ll?=
 =?utf-8?B?Y0FRL2VKNmdFVTRjRzE0Yi93S2JtWmRvNm1Ic2NOU3dxVTRxSWwxM2FSQkZX?=
 =?utf-8?B?MGpvN3U2ZkpXVkVnVnFiR2FSU1E1RC9IajV5R05MODR6R1I4SWlsNml5ZFUy?=
 =?utf-8?B?aUN4aG1UbnIwcnlCdW1mM3BxTHdEY0lLUHBGN0QrVnBZU3lCWVRQZUdPODZq?=
 =?utf-8?B?b2FMZTE0MEwxWnFTc05naVZBM1ZrM0M5V2R2bzlZVHlrYktsRCs1cWNaanVj?=
 =?utf-8?B?YkpkSkhvRkhUOUJKcElxbHhqS25Nb0dhS2V2NWJERTgwaHQ3Y0ppVWwyS0ht?=
 =?utf-8?B?dmVhcnJVRUJrUmducGVYZmt5ajdEU3RJNU5Ub1Z5Uk5ITUEzSGE0WThMV2E0?=
 =?utf-8?B?cGFQL1lSVVRwbUVBaGhSakRwdjBJODNHT2NXUGQ5QUhVTklHSElNYURTcml0?=
 =?utf-8?B?a0ZsbCtuTG1YdmdKdEtvUFNwRlR6Q3dmVkplYXVSMWRSQ2hyZHYrSGU1OWlk?=
 =?utf-8?B?bFlzMy85NVNQdG14YTQxbU9YVkhkcVRNKzRHWmNsK3ZuZlJHYU1Zc0k1MGJL?=
 =?utf-8?B?RnR0T3hnMU9uRGQ2cFJKQWErZ3lVb1B4VTNRa2NBU2ZmaWtTVFhrNDVQRUYz?=
 =?utf-8?B?ME1yQ0lIVThlS09BNnlqVDE5MDZOQ2V4NEI2Q1A0ZlZELys4VzlSQ3V2R0g4?=
 =?utf-8?B?cTc5ekcrTnhubkx3MmtiT1V6S2dVT0kzNWU0QTZSRUlrZEN6dlBRbHVNUWhp?=
 =?utf-8?B?L3MraTVHaXlqbFk5dVliNmx1c0ZNL21VRll2MDZIVTZETjNGRDFuOGFHZi9S?=
 =?utf-8?B?c3N4V09rWHZpU0NiYUV0dnkya3hwWHBJRmNRajR0b25Ta3YwSGlHZFNhbmxx?=
 =?utf-8?B?dndPdnh2N1VSb3JvUXVIUUJEb0xTOUZKYkFkd1h6YmJ3b3QzQmV0MFFRMWxi?=
 =?utf-8?B?MkVIcHhvcXJYZEdYZlhPNW5Xak93VDVGdlQrOU9EYUJKMmJwbVhNdEZzQkIz?=
 =?utf-8?B?aE5FQ0RzcXIwakhic3hOakFHVjhCb21nNU5FdUUyWVF2S09CdTkxanRyWWg0?=
 =?utf-8?B?VWtDNkZiOEhyUkdCSVpJM2FxMFZDbU5mdmIxVVYyQXhVNWJPZ0ZZaXlGTWVM?=
 =?utf-8?B?TkpWVCtoTkZxdm1FT0gySSs4TURiREZIUnR6ZEJESGJkbWdNclpwWU1uT0l3?=
 =?utf-8?B?S3c3ZW1laW1nT2dOQlpjeUg0eEE1RXJOQ3dZUFVya1ZaRWJ4N3dPanl6YU5W?=
 =?utf-8?B?UjVrL09qcXN3WmtPK0JudkNjUGRrbWhNRXRLcUNHcU5WMGJWQ0cwbmpLc3lZ?=
 =?utf-8?B?MklHUWFYQ0YrK1RTQUh0U2dybS9WN3NVejZwZitpUkhTWTF1WWhDL2VhUEZv?=
 =?utf-8?B?SDBuMXpick5zS1ZmaFdpWkYvNXlWN21BVjJWcmRndVY4eHgxUzQreXlSY2d6?=
 =?utf-8?B?eXU0ZGJXMHR6b2Y1ejFVY21NenVZeldHR0p4MFpSOUxPdFpFb1FhY1BpNjc2?=
 =?utf-8?B?UTBwWW5yeHhxTjdZWklhdDlJOUcreUw0OHJBUGZGd1FZTXRsbjlSNFd2d1Bn?=
 =?utf-8?B?ZE5kTWE0RHp1NDM3KzhEdHByWnJaRHUrQit5TnVTTGNvTnB6dDBlMGtZb2ZH?=
 =?utf-8?B?c0lCYWVxRjdQNkhINTk5SVd4K0sxVm5INEU4eUFkR0FoQ3plNGtQZFN1UGtS?=
 =?utf-8?B?REhqWHY1WTBQSmVWbWIxVUFqS3k0aXM2Q0VmY1c2SlVtTFljeTF2RUtOQXpF?=
 =?utf-8?B?M1VZbmFlQVQvRitYTDRIb1dlVDlteVJ2ZVZhWHpZY0NtanVrRENwVGI4bFQ0?=
 =?utf-8?B?WCszTUxsbTVWdGtZckhqY0tLOFV3K1dkdHJZK2c0WjNsOWJBWEFvMnFJamt0?=
 =?utf-8?B?Q05EOXYraXExZ2dBOUpabEFibkw2cVI4bGNQelNFMjNrRWxWL0xmNXR4UU1F?=
 =?utf-8?Q?Ksv6boEo+kgVrUWw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7086.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c568e8-8b0d-41dc-f809-08da3a68a1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 13:57:09.0322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3znNnPu89C0XK43ekuYg7UVfpWKSgZ4ZcIAe2m9iIxjVJKmyMgD4PtG1it5fMoE4Ny3Ovys+6YiXAdDSe6fQvacH1WTdjjZDiDmpHyj6IuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10102
X-Validation-by: julia.lawall@inria.fr
Subject: RE: [cocci] [RFC] coccinelle: Add test for unnecessary check before
 calling clk_disable_unprepare()
Reply-To: Phil Edworthy <phil.edworthy@renesas.com>
X-Loop: cocci@inria.fr
X-Sequence: 405
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/TYYPR01MB7086773272C8B95C344E663FF5D39%40TYYPR01MB7086.jpnprd01.prod.outlook.com>

SGkgTWFya3VzLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXchDQoNCk9uIDE5IE1heSAyMDIyIDIw
OjUyIE1hcmt1cyBFbGZyaW5nIHdyb3RlOg0KPiA+ICtAZGVwZW5kcyBvbiBwYXRjaEANCj4gPiAr
ZXhwcmVzc2lvbiBjbGs7DQo+ID4gK0BADQo+ID4gKw0KPiA+ICstIGlmICggXCggIWNsayBcfCBj
bGsgIT0gTlVMTCBcfCAhSVNfRVJSKGNsaykgIFx8DQo+ID4gKyFJU19FUlJfT1JfTlVMTChjbGsp
IFwpICkgeyBjbGtfZGlzYWJsZV91bnByZXBhcmUoY2xrKTsgfQ0KPiANCj4gDQo+IEkgZ3Vlc3Mg
dGhhdCB5b3Ugd291bGQgbGlrZSB0byBtYXJrIHRoZSBjdXJseSBicmFja2V0cyBhbHNvIGZvciBk
ZWxldGlvbi4NCj4gDQo+IEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gaGFuZGxlIHNpbXBsZSBh
bmQgY29tcG91bmQgc3RhdGVtZW50cyB3aXRoIHlvdXINCj4gc291cmNlIGNvZGUgdHJhbnNmb3Jt
YXRpb24gYXBwcm9hY2g/DQoNClNpbmNlIHdlIG9ubHkgd2FudCB0byB0cmFuc2Zvcm0gY29kZSB0
aGF0IGp1c3QgY2FsbHMgY2xrX2Rpc2FibGVfdW5wcmVwYXJlDQphbmQgbm90aGluZyBlbHNlLCB3
ZSB0ZW5kIG5vdCB0byBoYXZlIG11Y2ggY29kZSBsaWtlIHRoYXQsIGJ1dCBwb2ludCB0YWtlbiEN
ClNvcnJ5LCBidXQgbXkgY29jY2luZWxsZSBza2lsbHMgYXJlIG9ubHkgYSBmZXcgZGF5cyBvbGQg
c28gSSdsbCBuZWVkIHRvDQp3b3JrIG91dCBob3cgdG8gZG8gdGhhdC4NCg0KPiA+ICtAc2NyaXB0
OnB5dGhvbiBkZXBlbmRzIG9uIHJlcG9ydEANCj4gPiArcDEgPDwgci5wMTsNCj4gPiArcDIgPDwg
ci5wMjsNCj4gPiArQEANCj4gPiArDQo+ID4gK21zZyA9ICJFUlJPUjogY2xrX2Rpc2FibGVfdW5w
cmVwYXJlIGFscmVhZHkgY2hlY2tzIGZvciB2YWxpZCBwdHIgc28NCj4gPiArY2hlY2sgb24gbGlu
ZSAlcyBpcyBub3QgbmVlZGVkIiAlIChwMVswXS5saW5lKQ0KPiANCj4gSSBpbWFnaW5lIHRoYXQg
aXQgY2FuIGJlIGEgYml0IGNsZWFyZXIgdG8gc3BsaXQgdGhlIG1lc3NhZ2UgaW50byB0d28NCj4g
c2VudGVuY2VzLg0KPiANCj4gQ2FuIGEgbGluZSBicmVhayBoZWxwIGhlcmU/DQpTb3JyeSwgSSBk
b27igJl0IGZvbGxvdyB5b3UuIFBlcmhhcHMgeW91IGNvdWxkIG1ha2UgYSBzdWdnZXN0aW9uIGZv
ciB3aGF0DQp5b3Ugd2FudD8NCg0KVGhhbmtzDQpQaGlsDQo=
