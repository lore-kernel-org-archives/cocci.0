Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190FDC6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 09:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WLJqVXnr0FLHmbTVkxFpj/roPLSwgC9nRgu9Ns46CCQ=;
  b=iupg1La6zA7MYlnY4F7PKLjB+949xLrA1q42i6F7RsEIGdHr+CfMEYu2
   wqA4fNWzJY7hUZH8l7RY7gQxruLaMig4ZzYQA8CPoJSp1ZSCdfn9Z2YGd
   kC8Be9KiHCskeSKLaTp+w6v2XKqkSq/jw7ZOD3Lv2WQycfJm5tuXtYmnt
   4=;
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99044946"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 10:07:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 759CDE0D44; Sat, 25 Mar 2023 10:07:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4B0B5E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 10:07:35 +0100 (CET)
IronPort-SDR: 641eb9d6_wSSgs41aHdS/VjLbv1wEhQ3Wm4GkkaYr20zmcGnISbt9IBh
 HwomTrk4WatjIOXHt6LO3PEk7AZi62QuQ4/zGyg==
X-IPAS-Result: =?us-ascii?q?A0HHAAD2uB5khwwR49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YItgUsvBAtGhFORAS4DhC+HLJAjgxY+DwEDAQ1BAQIEAQEDBDiERgKFOgIdB?=
 =?us-ascii?q?wEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXB?=
 =?us-ascii?q?w4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHUz0DA?=
 =?us-ascii?q?yMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQexJn8zgQGCCAEBBpwKH?=
 =?us-ascii?q?ywiU4FeCYEULQGMRT+DNnonD4FVRIE8DIM1iByCZ4EMmAo8CoE0dYEgDoE9g?=
 =?us-ascii?q?QQCCQIRa4ESCGs5gURAAg1kCw5vgUoCZEyBHiUEDgMZKx1AAgELOzo/NQYDC?=
 =?us-ascii?q?yAGWGsCCSMREwUDCxUqRwQIOQYcNBECCA8SDyxEDkI3NBMGBVcBKQsOEQNQg?=
 =?us-ascii?q?SIfBgQkZoEBBgEmJJpxAgGBa3wBgQ5xgTdNLZIyCrA9NAeCKIFVgVkMnwwGE?=
 =?us-ascii?q?y6XCA4GkiOXaiCneoF5JIFcMxokT4JnTwMZD44gGR6Dbo9HQDQ7AgcLAQEDC?=
 =?us-ascii?q?YVGAQGFewEB?=
IronPort-PHdr: A9a23:PSRL+Reyf4mlpEdBsMc92A5clGM+3NfLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWUG9+HtLkd0bWempujcFJDyK7JiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhEmjqwbalsI
 Bi5rwjdudQajZVgJ60s1hbHv3xEdvhZym9vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2T
 qFWASo/PWwt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WSin4
 qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXHdNUtpNWyBEBI63c
 okBAPcbPetArIfzqVQBohWjCwesGu3i1DFIiX3q0qM1yOkhDRjG0RY8E94SvnnZrtP4P7oSX
 +Cvy6nIyC3OYfRM1jfn64jIbwshquyDU7J0f8rR00gvFwXKjl6NroHrOCma1v4Os2iG9OpsT
 +2hi2opqwFrozivwMgsh5LHh40L0V/I7zh2z5gsKNC+VUV0bsKqHoFKuCGGK4t5XNkiQ2dwt
 Sg117ALu5+2cSsUxJklxxPSZPiKfouI7xzsUOudPTh2iWxhdb6hhxu//kytx+/8W8e731hEr
 iVIn8XCu34D0xHe7NWMRPhl/kq5xzqDyh7f5vtaLUwql6fXMYMtz7wqmpYOr0jPBiv7lUrsg
 KKYa0ko4Oul5/n9brjlqJKRMZJ/hBvkPaQ0gMO/BPw1MggQUGif/uSxzLjj/UrkQLVWlPE3n
 LfWv4vAKcsGuKG1Gw5V0oA95BajFzqqzskUkWcdIF5bZh6KjZLlN0zMLfziEPuznUygkDJxy
 PDHOr3hDI/NLn/GkLr5erhy8VRcyAkuzdBE/Z5aBbUBIPzpWk/wstzYAQQ0MgKqzOn8Etlyy
 50RVXqJAqCCKKzSq0OH5vozI+mQY48YoCvxJ+A/5/HylX85hUMdfa6x0JQLb3C3AuhpI0SCb
 Hr3gtYBFH8KsRAkQOzrjl2CSz9TaGyoU6Iy/DFoQL6hWITOXIaghPmD1SG6AppMfUhYBV2WV
 3TlbYOJX7ELci3WastglCEUEKOqUI4Jyx6jrkn5xqBhI+6S/TcX8drG7OQwyfDIlBY00T1yE
 tTby22JZ2tumWoETDgzmqt4pAg18V6f0blxy8RCHN9a/PMBBhwzKZ7NxqpiEdnxUxnBVt2TT
 1+qSdKjRzo2S4R1i+QUbkt+EtO+jlj50iamEvdBjKaGCZ899L7cmWL8K8ps43zc06AthF4jB
 MBIMDvizpVi+AHVDpLJ232Dnqy3PZ8B1jTE8W6FzCLap1xXWQh5TaWARWoWbFaQtsnz/ErHR
 rmvIb49NQJNwsmHbKBNb4u6o09BQaLGMc7dfnn5tmO+HxeOyfvYSYPweHgGmgjZBlIFlQ874
 nuMcwQzUHTy61nCBSBjQAq8K3jn9vNz/TbiFhdcJ2CiakRg0+Hw4RsJnbmHTOtV2LsYuSAno
 jEyHVCn3tuQBcDT7xF5cvB6ZtUwqExCyXqfrxZ0a7mpNaN/nRgzdwptvkXh/wp6AMNMnJtit
 2skmTJ7MrnQy1Zdb3Wd1JH0NKfQLzzX9QqsdrWQ91XQyteQ9Y8Q5f5+p1iw9BqxGB8E9HNqm
 8JQz2Pa5pjOC18KVontV08s6xVgj7TdfzV7+I7ek3FhWUWtmhnF3d9hRO4syxL7OsxaLLvBD
 wjqVcsTG8mpLuUu3VmvdBMNeu5IpuYyOIu9ev2K1bTOXq4olS+6jWlB/IF2016dvyt6ROnS2
 p8ZwvaelgKZXjb4hV2lv4j5g4dBLT0VG2O+z2DjCuszLuVXdJwIFHzoDsm53NR4iLbyVnQe+
 FPiT1IK1cm1eAaDOkTn1F4Y3kAWrHq73CqgmmYtyXdz9PXZhXOImr6xEXhPcnRGT2Rjk1r2d
 I29jtRBGVOtcxBsjxy9o0Dz26lcoq17aWjVW0ZBOSbsfAQAGuO9sKSPZ8lX5dYmqyJSBa6Za
 EqZV6W7jh8UySLlEENByTp9ezzg6fCb11RqzXmQKnp+ti+TXMhqxgrEovHYS+RQ2DUuWyRyz
 zXaTAvZXZHh7ZCfkJHNtfq7XmSqW8hIcCXl+oiHsTOy+WxgBRDXc+mbotT8CkB61Cb604IvT
 iDUtFPnZZGt0a2mMOVhd00uBVnm6sM8FJss2oc3gZgR3zAdiPD3tTIimH3wLM4d9KbwdnsLS
 hYUztST7AWt1EB4L32Pzp70TT3Hm5EnPYPlJDpJnHtnp8lRQL+Z9rlFgTd4rj/a5UrKbP5xk
 y1cgfoi5XgGgv0Y7Q8kzyGTGLcXTgFTOS3hkQjN7sjr9vwNIjz1Lv7piwwnx4PEbvnKuAxXV
 Xfnd413GCZx6p46K1fQyDjo7ZmiftDMbNUVvxnSkhHajuETJohi85hCzSdhJ2/5umUojuAhi
 hk7l7SzpouaMCNA+KyjAxhXHiL4bYUf93u+6MQW1tbTxI2pEph7T38uVYHrUOnuPTYcr/XhO
 C6RHTd6pnrRSt+9VUePrUxhqXzICZWiMXqacWIYwdtVTx6YPEVDgQoQUWZyjtsjGwut3sCkb
 FZh62Vb+AvjshUVgLENVVG3QiLFqQyvcDtxVJWPME8c8FRZ/0mMec2GsrApRnsepMf+6lXXd
 CrCPVQPVzxsOATMBki/bOP3v5+aqbfeX7f4d7yUPP2PsbAMDa7Sg8j1jc0/oHDUcZ/Qdnh6U
 69hgxUFAio/QpWD3W9TG2tNxkevJ4aavEvuqncx957itq22CUS3otHRQ7pKbYc1ok/w3v3Fb
 bbPwn4+c2kQ14tQlyWRl/5AhhhL2nsoKWXqS+pl12aFTbqMyP8NSUdFNmUpbpoOtvlklghVZ
 ZyL0JWsiOM+1KVtTQ0fHRnonsXjDSATC0e6Ml6PREOCNbDdYCbO39myeqSkD7tZkORTsRS0/
 zedCU7qeDqZxXHvUFi0POdAgTv+XlQWsZyhchtrFWnoTc73Ihy9PthtiDQqwLoyznrUPG8YO
 DJ4fgtDtLqVpS9fh/x+HSRG4B8HZaGcnD2F6uDDNpsMmf5sHzgyiO9Qpng3ivNU4CxCWP1pi
 X7So9pp8DTE2qGEzjtqVgYLqy4e3tvR+x84ZuOAqd8ZAyWhnlpF92ibBhUUqsEwD9Tuv/sV0
 d3TjOfoLy8E9dvI/MwaDsySKcSdMXNnPwC6fVycRAYDUzOvMnnSwkJHl/THvFictJsnsd7Bn
 JQUS7lUfEM4HLUWBw42eb5KaIcyRT4inbOB2YQQ4mGiqRDKWMhAlpXAS+7UHvjlbjqUx+ohB
 VNA0fbzKoIdMZf+0kppZwxhnYjELEHXWMhEvixragJcSKpl73V0CGE+iRuNguaF/3IZU/K5z
 EZeYupWZOMw6HHz7l1xKleY/EMN
IronPort-Data: A9a23:8TQ2j6LdaVl57KLoFE+RqJElxSXFcZb7ZxGr2PjKsXjdYENS3jAEn
 GEeUW6BbviJNmfzKNFxb4zl/UhUv5TQydNiSlYd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWCfg71s9JIGjhMsfnb80ky5K2aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuV17g+/pQCG8NAJwT+cVMXm5A2
 783N2VYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHOOTv7e03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GiKmcB+QrI+sLb5UDC3Ste/pW8KODzc+yKecVxgUmn+
 nvJqjGR7hYybYHDl2PcrBpAnNTnliTwU4M6D6y97vcsgVuJx2VVBgd+aLegify+l1L4RN9Vb
 UAZksYzkUQs3GiOQuHyYRmWm0OVtR0/YIVfHcN5xx7Yn8I4/D2lLmQDSzdAbvkvu8k3WSEm2
 ze1czXBWmQHXFq9Fir1y1uEkd+hEXRFfDFdOkfoWSNVuIi9/unfmzqVFo4LLUKjsjHiMR3dq
 9xghAs3nbEIl9ML2s1XFniY3Wv99/AloiYf7wnaWCea8xlleIOgbYGy5jDmARtoKYGEUh+es
 XJCl8X2AAEy4XOly3HlrAYlReDBCxO53Nv03A8H834JqmXFxpJbVdoMiAyS3W8wWir+RRfnY
 VXIpSRa74JJMX2hYMdfOtzuWpp6l/e7TYW4B5g4i+aihLAuJGdrGwkxOiatM5zFyxdEfVwXZ
 MrEKp/1ZZrkIf03lGvvLwvi7VPb7nljmT2KHM6TI+WPiPTHLH+TVbofNlaSJuk2hJ5oUy2Fm
 +uzw/Cikk0FOMWnOne/2ddKcTgicCZnbbir9Z0/XrDZfmJORjp7Y9ePmuxJRmCQt/8I/gs+1
 irhARAwJZuWrSGvFDhmnVgyOO6+Acsv8S5T0O5FFQ/A5kXPqL2HtM83H6bbt5F+nAC65a4oF
 as2aI+bD+5RSz/K3T0YYNOv5MZhbRmnz0bGdSasfDF1LdYqSh3r6+3UWFLl1BAPKS6r6uo4g
 bmrjT3ATbQ5Gg9NMcfxadCU9W2Xg0QzouxJcnXtHshyY2TpqYhjFDzwhKQ4IuYKMhTy+QGZ3
 Ae3XzYd/PfBk7Yo/IP3hISBlYOIEvR/LGVeDWL0/ba7DgiE32uBkKtrcveEQiDZb0zwoJ6dX
 ORyy+ruFdE1kHJhkZtOI5wywY0Qv9LQ9qJnlCJ6F3D1XnGXI7JHIEje+/JQt6dIl4RriSHvV
 m2hotBlaKi0YuX7G1ssJS0gXOSJ9dcQvhLwtf0VAkHL1BVbzYq9c3d5Hkez0XRGDb5PLoka7
 /8ru5cW5yyBmxMaCIu6oR4OxVucDE4rcvsBhskBDZ7Jmzgb7AhIQabhBx/c5LCNbNRxMXcWH
 AKEuZqauZNiwhvtTnliM1nMwutXuroWsj9o0lIpBgqEi/jFtNANzTxT9jU7FDpU6hB918NyJ
 WlZGElnLoqe/zpTpZZiXkL9PypjFRGm6kjK5F9Rr1LgTm6sSmDpB08sC9anpUw23TpVQWlGw
 eu+1m3gbwfPQOjw+SkDAWhetP3pSI1KxD3owcyIMZyMIMgnXGDDnKSrWGsvrinnC+MXgGnsh
 7Fj3MR0WJ3BGR8gmY8JIKjE6u1IUzGBHnJIft959qBQHW38RiC76QLTF2+PIPFyN9742m7mL
 fw2Pc9edQWM5ADXpBAhOKM8CbtVnvko2dk8Ro3WNVM267uykz44n6/Tpw7fhXAqSepAicwSC
 J3cXBPcH32yhUl7oX7srs5FNjCGYP0BXgnd3f+0wsoNBZksoOFhSmBs87qW7lG+EhprwAKQh
 yzHP5Tp9u1FzZhgu6DOA5dzLVy4Bv2rXdvZ7T3plcpFaO3+FPvntiQXmwHBBBtXN75AYOZHv
 +2Bn/Cv1XyUoYtsdX7SnqSAMKx75c+Seu5zGeCvJVl4mRqyYuPd0yEhyUuZd6MQyMh84/O5T
 TSWcMGzLN4Ze+lMzU1vNhRxLUwvNLTVXIzB+wWN9viCM01Im0iPZtaq7mTgYmxnZzcFcc+2Q
 BP9v/G1oMtUtsJQDRsDHOtrGIJ8PESlY6Y9atntrnONOwFEWL9ZVmfKznLMKA0nC0Vo1O7/5
 o/ZAAfzflK+tckkCT2fX5Na5nUq4LRV2IHcvX7xP/Zphjr8AGNuwSE1L8AdEp8N+sDt/MiQW
 dwOBVfOzQ3iUD4CfRiUDBEPmOuALrRmB+oV7QDFM69Zh+layW9A7HZcGv9c3kpL
IronPort-HdrOrdr: A9a23:Xr4kuahFALvQCqWuYQNF8tOUWXBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW2ldAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykcsS+Q2mmF+rgbsby62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51219057"
X-MGA-submission: =?us-ascii?q?MDED84uOikT+xIxrYMEYVBLdUDBsJYm55gZRjB?=
 =?us-ascii?q?b3VzcqrgxTO2ndlf04TQu7Im4XZqJEl4C+bavwZ+PK4shRbTYRDLvB6L?=
 =?us-ascii?q?0xVSuqnRvkkakAyW11J83Sb+EFKGeoVhV0SWjYjsFYU0wyAWtnoZgaU6?=
 =?us-ascii?q?vVS/HAWT6RBW7dG8HUXvzzww=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 10:07:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679735254; i=markus.elfring@web.de;
	bh=MwgV0dmMiOFHjTAMybDdRhXxIiz2pa1tHj7LACECugg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=FB+OCyfixC9FsV6Xi4Qhv6cds79HeW8vy0hkbDLitYspvHokrXUVmUF3kDtflXHK7
	 wXjg2SINjzVXKfOpZlZtV8FaOkvXWRtCSl13S+g9/+p0K8/ysznJBWAMgKCL+uFt8W
	 v0C3IIgSnhp2Q5LGWQ4bFY1XLs0MejSmZvr8rUJhWCeSTnE/FX5xD8vHmCkdWeDA17
	 VAfGcFGf/UZvPhbCKmk2vMEwt1CemzRjhrizBnjXOLoYfU1WN+3aajDPCXEDJKfr5y
	 Unan07IIUackx57tFZA5KUqnL7sCe1ZCo6Zg2c4DeNwWtZ+mQ+cA3axNQoVrMM/d5K
	 boqrxg9RZWLCA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZHv-1q4UkZ0l6v-00SnlW; Sat, 25
 Mar 2023 10:07:34 +0100
Message-ID: <cfa97c3e-bfce-f407-4499-13151b1ca78a@web.de>
Date: Sat, 25 Mar 2023 10:07:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-scsi@vger.kernel.org,
 MPT-FusionLinux.pdl@broadcom.com,
 Sathya Prakash <sathya.prakash@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <46330de1-742d-f95d-e355-a214330698e7@web.de>
 <1595e3ec-d137-80f1-af27-b8fabd8bfd4f@web.de>
In-Reply-To: <1595e3ec-d137-80f1-af27-b8fabd8bfd4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DHLMeoTqSMM1pheTJG+J19FLu3C9yPJsn6CSPLFdRYiwZD1ExAL
 xHlNkqGcX+NOSu1liOOvGoGHPbFoQa5+TMldsbc7aWotY93K6mRtuWuUTlhtcaCVKi+5mU3
 v206eGVHY3fzQnqfaCvlhNrL8qvZcsetBB3vkva0cUehKwIjIh0a0GJAJzO971C5PpW2ueM
 wRHrvtPLG44nL38EvrU+g==
UI-OutboundReport: notjunk:1;M01:P0:8hw3L9SUJQ4=;xWL5VeDo7w/mkia37rooZW5HBuL
 GgB8HvQXoCnT/aRNbYWwlygBCLFay0GlyUPkNdXy/9Gc1d+oBoO7ClGidSwi23bRRbZTIC/TD
 pJP0CiIjdkDMuosSD8ZxG7IvuQ07ps12j7O5RsOzd3GoQTHTQOtFeFia0o6iUspabRbu1cUve
 LVfvtEDE7E4e/o2UMX+tbo1WuIJP0GeV+kmUQIXPf7gAWZIP8rTaK+oqW5wjG+tAQYgb3M6/0
 /OlqghqdtjVGRYGAScAUSBtDNKFmmCBrRlVHlk9eRXnuR8M2QfBCEqKFKXLbNndMYcvaPOm99
 UCaXgU/T2GoXYTkpUhLO3saJ+yd9WYUoIV5dpEA2Ev3Q4RkmK9Oz8FwxBp/Hu4KiYkBwdXhKC
 gauht3SRYa4V8bHSj5N2crQRov61aS+KyP8vVkcOu58iOXAzj662T/KkIgv03ew3pWB8EyIT4
 W4fTatXQtefQDa4iIqQcQtvWM9IbNwAJNFxL1zWIcLWX7FqdLq0zRhwU7rMY8CNm+b4rCzcss
 F+Rs/rRGqkl4lF2r/1ZO6j3JGX0bZ+Loa12qoKy+wYPv64xM3qRHU7spC9wK6Ia4uksGTEIo2
 ggS8zUhJFUB97TuafzWWPZUs+38W48NtgHzBAImt9ERTVy0H7iMRudhVRHeemR6HBxS+P0OOl
 0Zi/Pzdbj+6YU0DnCoEBBouJQGASTvusrixuddnk6d4H+cmhJlYzI+IejGANY71CYblgcy81R
 CUE+qwA0DzKuDe64H1/jFB279VpXv+Ff/N58UHjIapW322qhOAqwyMPKGBRyGANWMTVEn+bUN
 txlL6OafAtJX4NAnsvgDH9XBfQEiRLZIamC3DqqWmQqDkRsxdteVb81F0J9pR3LHTwnVFqAOS
 EI97Jw5+YCLX4maGG52J4nDRRQcRXa4JUSNrib4BP+YXQdfWKfG9+VEVM
Subject: [cocci] [PATCH resent 2/3] scsi: message: fusion: Delete a
 redundant pointer check in four functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 927
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/cfa97c3e-bfce-f407-4499-13151b1ca78a%40web.de>

Date: Tue, 21 Mar 2023 16:00:25 +0100

* Use a more appropriate label instead.

* Remove an extra pointer check which became unnecessary.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/message/fusion/mptbase.c | 27 ++++++++---------------
 drivers/message/fusion/mptsas.c  | 37 +++++++++++---------------------
 2 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mpt=
base.c
index 4b097c1f95cb..59420590c5f7 100644
=2D-- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -5677,11 +5677,8 @@ mpt_inactive_raid_volumes(MPT_ADAPTER *ioc, u8 chan=
nel, u8 id)
 	cfg.physAddr =3D dma_handle;
 	cfg.action =3D MPI_CONFIG_ACTION_PAGE_READ_CURRENT;

-	if (mpt_config(ioc, &cfg) !=3D 0)
-		goto out;
-
-	if (!buffer->NumPhysDisks)
-		goto out;
+	if (mpt_config(ioc, &cfg) || !buffer->NumPhysDisks)
+		goto free_dma;

 	handle_inactive_volumes =3D
 	   (buffer->VolumeStatus.Flags & MPI_RAIDVOL0_STATUS_FLAG_VOLUME_INACTIV=
E ||
@@ -5690,7 +5687,7 @@ mpt_inactive_raid_volumes(MPT_ADAPTER *ioc, u8 chann=
el, u8 id)
 	    buffer->VolumeStatus.State =3D=3D MPI_RAIDVOL0_STATUS_STATE_MISSING)=
 ? 1 : 0;

 	if (!handle_inactive_volumes)
-		goto out;
+		goto free_dma;

 	mutex_lock(&ioc->raid_data.inactive_list_mutex);
 	for (i =3D 0; i < buffer->NumPhysDisks; i++) {
@@ -5713,11 +5710,9 @@ mpt_inactive_raid_volumes(MPT_ADAPTER *ioc, u8 chan=
nel, u8 id)
 		    &ioc->raid_data.inactive_list);
 	}
 	mutex_unlock(&ioc->raid_data.inactive_list_mutex);
-
- out:
-	if (buffer)
-		dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
-				  buffer, dma_handle);
+free_dma:
+	dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+			  buffer, dma_handle);
 }

 /**
@@ -6258,17 +6253,13 @@ mpt_get_manufacturing_pg_0(MPT_ADAPTER *ioc)
 	cfg.physAddr =3D buf_dma;

 	if (mpt_config(ioc, &cfg) !=3D 0)
-		goto out;
+		goto free_dma;

 	memcpy(ioc->board_name, pbuf->BoardName, sizeof(ioc->board_name));
 	memcpy(ioc->board_assembly, pbuf->BoardAssembly, sizeof(ioc->board_assem=
bly));
 	memcpy(ioc->board_tracer, pbuf->BoardTracerNumber, sizeof(ioc->board_tra=
cer));
-
-out:
-
-	if (pbuf)
-		dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4, pbuf,
-				  buf_dma);
+free_dma:
+	dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4, pbuf, buf_dma);
 }

 /*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=
=3D-=3D*/
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mpts=
as.c
index e0e861e79e64..5c51339dfb9f 100644
=2D-- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -708,11 +708,8 @@ mptsas_add_device_component_starget_ir(MPT_ADAPTER *i=
oc,
 	cfg.physAddr =3D dma_handle;
 	cfg.action =3D MPI_CONFIG_ACTION_PAGE_READ_CURRENT;

-	if (mpt_config(ioc, &cfg) !=3D 0)
-		goto out;
-
-	if (!buffer->NumPhysDisks)
-		goto out;
+	if (mpt_config(ioc, &cfg) || !buffer->NumPhysDisks)
+		goto free_dma;

 	/*
 	 * Adding entry for hidden components
@@ -763,11 +760,9 @@ mptsas_add_device_component_starget_ir(MPT_ADAPTER *i=
oc,
 		list_add_tail(&sas_info->list, &ioc->sas_device_info_list);
 	}
 	mutex_unlock(&ioc->sas_device_info_mutex);
-
- out:
-	if (buffer)
-		dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
-				  buffer, dma_handle);
+free_dma:
+	dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+			  buffer, dma_handle);
 }

 /**
@@ -4276,15 +4271,11 @@ mptsas_adding_inactive_raid_components(MPT_ADAPTER=
 *ioc, u8 channel, u8 id)
 	cfg.physAddr =3D dma_handle;
 	cfg.action =3D MPI_CONFIG_ACTION_PAGE_READ_CURRENT;

-	if (mpt_config(ioc, &cfg) !=3D 0)
-		goto out;
-
-	if (!(buffer->VolumeStatus.Flags &
-	    MPI_RAIDVOL0_STATUS_FLAG_VOLUME_INACTIVE))
-		goto out;
-
-	if (!buffer->NumPhysDisks)
-		goto out;
+	if (mpt_config(ioc, &cfg) ||
+	    !(buffer->VolumeStatus.Flags &
+	    MPI_RAIDVOL0_STATUS_FLAG_VOLUME_INACTIVE) ||
+	    !buffer->NumPhysDisks)
+		goto free_dma;

 	for (i =3D 0; i < buffer->NumPhysDisks; i++) {

@@ -4311,11 +4302,9 @@ mptsas_adding_inactive_raid_components(MPT_ADAPTER =
*ioc, u8 channel, u8 id)
 		    sas_device.sas_address);
 		mptsas_add_end_device(ioc, phy_info);
 	}
-
- out:
-	if (buffer)
-		dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
-				  buffer, dma_handle);
+free_dma:
+	dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+			  buffer, dma_handle);
 }
 /*
  * Work queue thread to handle SAS hotplug events
=2D-
2.40.0

