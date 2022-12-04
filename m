Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95374C4332F
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 13:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cXirGt6DTSEup4DSKT7Y08JlFh5qOIEJvkh3uzKGGDo=;
  b=RDKRvetzPvC+Qs7jKWdsb73/fkufhm2lLnhIgucH789YKTyz8QaddQo8
   mKWcVdFJBcUWqA3NNOGS53aqN3Y9Mip23XvSU/IP+h1Qc0IF11mEawC8o
   9ggTdxjMFQlBH4NsFmWPyRwtYvyv+HT5jfWzwbNnUOX0FfPk4wfWYe5Ho
   w=;
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
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81593979"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 14:36:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D8D17E01D1; Sun,  4 Dec 2022 14:36:35 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C1377E013A
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 14:36:30 +0100 (CET)
IronPort-SDR: 638ca25e_hi1Hvm6b0A5he4pKo+1E7ABWf3Ee+96/DfgmqD1gJ289+WB
 nfMZuAuLT5kNXMRaunM9CYzYKVNCI7Ju8T5TljA==
X-IPAS-Result: =?us-ascii?q?A0FTAAB2oYxjh07ASNlaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YIsgVsuBAtFhE+Od4IohCuHIocwiGKBVoFAPg8BAwENQQECBAEBAwSCC4JzA?=
 =?us-ascii?q?oUPAh0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABA?=
 =?us-ascii?q?QEYCxcHDhAFIoVoDYI1KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESA?=
 =?us-ascii?q?kdTPQECAgEjHQEBERsMBAsLGgImAgJXBgEMCAEBF4Jjgm4BAw4jB650gTKBA?=
 =?us-ascii?q?YIIAQEGnAcfLCJTgV4JgRQsAYxnhDAnEIFVRIE8gwM+hESDV4JnjFKKKWIlB?=
 =?us-ascii?q?A4DGSsdQAIBC20KQzUGAwIRTCscGweBDCoJHxUDBAQDAgYTAyICDSgxFAQpE?=
 =?us-ascii?q?w0rJ28JAgMiYQUDAwQoLAMJIR8HFREkPAdWEiUBBAMCDyA4BgMJAwIiVHMCC?=
 =?us-ascii?q?SURFQUDCxUlCAVJBAg5BQZTEgIKEQMSDwYmRQ5IPjkWBidyDg4TA12BaQQzZ?=
 =?us-ascii?q?oELCl2cToElgTKSGq98NAeCH4FNgVAMnmkGEy6WcA4GkhaXPyCnWoFjATiBX?=
 =?us-ascii?q?DMaJE+CZ08DGQ+OIBmEDIosQDQ7AgcBCgEBAwmFRwEBhFYBAQ?=
IronPort-PHdr: A9a23:YlTw/x2y5tK5azfcsmDODA4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaCo6w3xwKVFcWDsrQY0baQ6/ihEUU7or+/81k6OKRWUBEEjchE1ycBO+WiTXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba1yI
 RmssAndqMYajIttJ60szhfFvmZEd/5ZyG92Kl+fhQrw6tu18JV+7ylepvUt+tJPXqn9Y6k2V
 6FTAi48M2Ay6s3rtB3DQhWK63ABTGgYkQdGDhbc4h3iUZj/riX1tuxm2CmHJsL2Vqw7WS6j7
 6hwVhDljjoMOiMj/2HWjsxwi79boA6kqhdizYPYfJ2ZOfxjda7GY9gUWXROUdpQVyxZA4Ozc
 Y0PD/YaPe1Fq4XxvkYCoQeiCQWpAu7k1z1GiWLs3aAi0OovHw7J0wI9EdwQvnTarNf6O7sdX
 +2u0KnI1C/OY+9K1Trz6oXFdA0qr/GWXbJ3dMrc0U4hGBnfjlWTtIzlJC6e2OsJs2iV9epgV
 OSvi2E6oAx2pTag3N0siorUhoIO0FzK+iF5wIgvJd25Tk57bsWpEZVOuC6BLYd5X90tTnhut
 S0nxbIIpYS1czIWyJQ72RHfcfqHfpCH7x/+W+ucIjV1iG97dbywmRu/8Vatx+PiWsS60VtGs
 ilIn9fRunwRyRHd5ciKRuZ580qjxTuB1x3f5+FKLE06k6fQNp0vwqYom5YNrEjOHDX6lUfog
 KOMa0kp/vak5/7lb7jlvpORM4B5hhvwP6gzgMCyAuo1PhINUmWV/+m3yaft8lfjQLpQi/07i
 qnZv47eJcQcvqO5BghV0ps/6xqlATapzs8XkWMaI11bYB6Hjo7pNE/SIP3gE/uznlahnC1py
 vzYJLHtH5HAImbZnLrjfrtx80tcxxAyzdBb6ZJUELYBIPfrV0H2rtPYFBw5MxGvw+r9B9t90
 o0eWXiOAq+fP6PfqlGJ6fw0LOWWeYAapi7xK/4+6PH2l382hUcdfbW13ZsQcH20AOxqI1+Fb
 nr0ntcBDWAKsxI6TOPwhlyNSzpTZ3KpUqM95zE7DZmpDZ3ZSYy3gbyB2j27HpxMaWxcBFCMC
 2/kd5+YVPcUdCKSPshhnyQYWrimV4AuyRCuuRThy7tnK+rU4jcXuYji1Nhz/e3TlAs9+SZ6D
 8SHgCmxSDRWg2cJTncS1b92pUg1nlWe1alxxfhRCtVX49tIVB07PNjS1bo+Q5reVxjMfZ+sD
 h6ERdOrGnt5Gt482dINS0V7HM6lgFbI2Gy3AOlR37eMD5c12qPaxXn4YchnmFjc06x0qlA8Q
 dZUfUCiiLR+8QebU6vAiUaEjOCHcaoG3SjC3HiOxyyCsRcLA0ZLTazZUCVHNQPtptPj6xaHF
 uf2YVxGGg5IyMrYb7BPdsWsl1JNAvHqJNXZZWu13Wa2HxeBgL2WP8LxY2tI+iLbBQAflhwLu
 26cPF0bDz2ivnmYIThgD1PpbGvz/OM4pH7oBlQswVSyZlZ6n6Gw5gZTgPWdT/0J2bdRnS47q
 ChvWnu50cjXDdWouAdrOqlRMpsm+FkS82XfukRmO4C4aaBvgllLawNso0bnzAl6EK1FltU26
 mwnxkx+JMp0yXtncDWVldD1M7zTcCzp+Qy3LrTR0RfY2cqX/aEG7LI5rU/itUenDBhq9XIvy
 NRT33aGg/eCRAMPTZL8VFo2/BlmtvnbZCc6/YbdyXxrN+G9rDbD39sjAOZtxAynep9TN6aNF
 Qm6FMN/ZYDmDeUwmEWyKD8AMvpT8qEcIM6sMfeLmeaqMOtmgDO6nDFf+okumkmI9id6VqvJx
 8Nfmq7egVHBDmamygjx4aWV0cheaDofH3Sy033hDY9VPOhpeJoTTH2pKIuxz8l/gJjkXzhZ8
 kSiDhUIwpzMG1LaYlrj0AlXzUlSr2agnH7y6jVukCwy6Ieb0jbPxevKaxcNfGJGDjoH7x+kM
 c2vgtYWUVL9JS0gjhi4/gDXw6ZBpaJwB3beSwFEcmKlSgMqGrv1vb2EbclV7ZouuigCS+Wwb
 2eRTbvlqgcb2Sfud4dH7AgybCri+pDwnhggzXmYMG42tn3SP8d52RbY4tXYA/9XxDsPAidi2
 3HbAV21Pt/h+tvx9d+Ll+mkVH+6ELBXfzPqy4yoqyaxo2FnSRGyhPG8nNT7HBNyi3akkYYwE
 3yZ9lCjMsHizOyiPPhif1V0CVOZiYIyAYx4noYqxdkR1XUcmpSJ7C8CmGb3P89c3PG2Z34MS
 DgXht/NtVK8hws8dDTQlti/CSXOp6kpL8O3aW4XxC8nusVDCaPOqadBgTMwuF2z6wTYffl6m
 D4Zj/oo8n8Txe8T629Phm2QBK4fGU5AMGnijRONupqbpb9UeX3pXLy+zkt4kvi+AbvErgwWC
 xObMt8yWDR96MlyKgeG9XTp6Zz/PvTUY8gSsBK8jBrKyeRYYsFU9LJClW9sPmTzumcgwugwg
 El13J20i4OALn1k4KOzBhMLfi2wfc4Y/SvhyLpPhsvDlZ76BY1vQ39YOfmgBeLtCj8Zsu7rc
 hqDACFp4GnOAqLRREee8Bs09SuVVcrxaDfOfidflI8yA0PAQS4XyAEMAGdgx8R/TFr1gpW8N
 h8+vG1Z50ak+EEVkKQybUa5CziZ/EDyNX81UMTNdkMJqF4YoR6Ea4rEsrI0RXA9nNXprRTRe
 DzBIV0WUCdQBx3CXxe5YPGv/YWSqbHHQLXkaaGWPvPW7rYBH/aQmcD1i9QgoGzKb5TVeCc+S
 KdlvygLFXFhR5aJwXNWFXFRzXicKZfA/F+94nEl/pr5qaq2Hli0vc3VUfMXONFrsXhamI+lM
 OidzGZ8IDdcjNYXwGPQjaIY1xgUgj1vcD+kFfIBszTMReTegP0fCRlTcC51OMZSisB0lgBQJ
 c7WjM/03b9kn7Y0DVlCT1nohsCuY4QDPWi8MFrNAEvDOq6BIHXHxMT+YKX0TrM17q0crxqrp
 TOSCFPuJByGkCT1EQ+iO6dAgWDTPRBTvp28bgc4CWXnS4GDCFXzO9t2gDsqhLws0ymTaihDa
 34lIhkL8e3DiEEQyu9yEGFA8Hd/eOyNmiLDqvLdNo5Tq/xgRCJ9i+Nd5n0+jbpT9iBNAvJvy
 06w5pZjpU+rlu6Xx39pSh1L/3xujZiIoF4kFKHX7JhGVl7b8RhL4WjaWHFo75N1T8bivaxd0
 I2FjKXoNDJL6M7Z5+MZANXIbt2KOjwtPFC6fVycRBtARjmtO2bFgkVbm/zH7XyZoK8xrZ30k
 YYPQLtWPLTaPuwXAAJpEY5bSH+WdjYjjKLdk8MCo3az/kG5rCByoZ3NEP6fU62HFQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kLtUn6wRt+QjaKEt4bxuKrPw8r1zdoMgy1knxilNoG9uA6+lfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 JdmsNFaOEYY2IK7/rS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81593972"
X-MGA-submission: =?us-ascii?q?MDHuQEoaSkn9Z2392hBInyL5bqPY6SiSf6Izmf?=
 =?us-ascii?q?MgV1r7rZG/tmsHrMTgopBy8JDaN7frs6z+zoaRE4f9QJH4AC3jGsBZec?=
 =?us-ascii?q?U1ZNpl6hwhd/A4kP8TXyEAxwYq8SW0X5dpS4WiWVwwgcnAJ+myYf5sB0?=
 =?us-ascii?q?ImAkfxGec7Oiq4k+FOP4A3iw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 14:36:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1670160989; bh=zcvPX/Mj+60DZZMuclO9gDS92HZz3vQPRiYEEc3pJuc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=k4eJkONNl4/teD0JFgUn+qOwFkMvrZxu56gUN3ki8IiCzxDc9I/EcCiaNF8/chMRN
	 OI6MABE3fBC29+bdJniOHNjA6a+yeiPVfM+Z63AHwLMh/C10fYGoux9wBt04Zte00m
	 z2RAY2TMIeDDUIDs0pkf/ZFTkLFrQXfEVQJaeQMUnGdiXpQrtsnxt+te8O7fbwYENU
	 JYiBJ7pkoXFvTyi8RyroBrwQJ2vPRwOC3dpSx6NCLa4l/53ahQsacOriMch0JD7Nne
	 Cvdxb8qUzCWUJ2tDlTXKuDJArESkrZUqzZHtUQIMjChHDWyppRWdMJlorxagivssoh
	 MJI0sBMyM5qSg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myv72-1op7bL2fTu-00w6eH; Sun, 04
 Dec 2022 14:36:29 +0100
Message-ID: <b404ba8b-df56-1f22-c0c4-a3d3be6aea30@web.de>
Date: Sun, 4 Dec 2022 14:36:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, "Derek M. Jones"
 <derek@knosof.co.uk>, cocci@inria.fr
References: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk>
 <alpine.DEB.2.22.394.2212040832050.3337@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2212040832050.3337@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A/pFbKzjCVmcwJBavPUrn12v8JVyK42XKPT+lDUBTpPj3ny9OeG
 C75YRe7HVStrIjflXZcElzfe82YLMRcqdKYfEL5hcAHOKlQZ7F35DpIBwfJ6az1ATYQggSu
 V4Smy+4C5ZrtKXnWQ94mvxuLjDaV1YEvuwSf5iUcuFf7NxlR4lHILgfsrHp6U8ETaOpXlMt
 +9V6sDROi472fPhuUefQg==
UI-OutboundReport: notjunk:1;M01:P0:tHzfzNcQ/OQ=;WTUnZy4H5wRxHKyADh60MQHRxcl
 0KKo3xm7kAQ6KwshcQtZqaOCPno8JvhI7aDGDJ1sWeswaUXq0LAz5oif+wA1mvTY34rhRnpdO
 lNSGRbh7jXi6/MtqRlaj8m+qQ3up+50EtIgmqCeNk4/+oGRa0npLAeYmItPdUHQ+PPKEw/ca+
 4rwY7+/Q0L32cSZ4N0xPHXhY1S+zXr9T9rj9fNtsPVfHmQpUMWL6IJrrKknGXT8yzEhintcSc
 Ut5o56fsWSWXrxLNsgSiprWhITMLp5dRXpMLRlr+ENm4IT/PpOC/a22wTwOtlaQl6rae0zi55
 frTwDvLelS6THPPjGGNv1+iJkJPCFPVfI2KDXvTg7qECcOaXSve3BA+2merSLIRlTbvaunJuK
 unvePQIADtSQzYTZRSyne5kVnfIvmsGSt8AufvYSFd/hiMWsx56ISX7hrxJY4bU2vbcKeX5+m
 Yuen5Xui3zetG4x2g71T+9qLhtJYwqPGTNzSiUBR90URU0gF9AJyJWDurDcBNkUJ2e/HNW8tV
 ZDJjDZOpRtWpSK2dxGehUOLL1QlireKbTn9QXW893lh6DLGyO/1Drvi8RGf5Lhhr74CHJ3EWZ
 dnbFIPxYxkMEzvrOa2Su/QWcloO6JMdtCfNaDRvAX++HizJ26YKQx5wpCBm6sSzLTjRO7H9JN
 z9ET1z+KdiFo2puQJq7kNWkiX4OO3Lp2usK3iaQukYW7OqN2+BX/Nrz4urJlzIhZR1B9s5LIM
 Kgi9Uix5xkPzeD4f7qj+/GFAwf/mk/NI5oquNQp14jifO/dWMVaZmk5kFczp12KhlegRQkLZR
 mthrG4yt7i9mBCyKGokGegNcft6v5l/aNOPHVUTF4dc0W4Ak4DyM02cgXL2UGjIM+Pec6XP7U
 kVO8EPfG9HmjWHu+ZJhe1gcOSh/YZ2/H8M+l1S9++0IHbiRupImKeQ/9xvdaiwMs3iUgZz+Md
 4B0AXw==
Subject: Re: [cocci] Clarification for SmPL search techniques
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 764
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/b404ba8b-df56-1f22-c0c4-a3d3be6aea30%40web.de>

>> I' having the usual problem that occurs when using Coccinelle
>> after a long time away, I cannot find the example I need


Would you get any further development ideas from information in mailing li=
st archives
or issue trackers?


> The problem is the ...  That matches the shortest path between the thing
> before and the thing after.  So you only get the first match.  With the
> semantic patch as is, you get the |=3D line, and if you replace binary b=
y
> assignment, you get the line with the +=3D.


Will such technical details trigger any further collateral evolution?


>
> Intuitively it would make more sense to replace the ... by <... ...>.

I imagine that the SmPL construct =E2=80=9C<+... =E2=80=A6 ...+>=E2=80=9D =
can become relevant.


> But that doesn't work either.  It matches everything, but they come out =
in one
> match, with a list of positions, and you only print the first position.


The data output can be adjusted accordingly.


> Another approach is to replace the ... by ... when any.  Then you get
> individual matches for each reachable assignment, and you get four
> results.
>
> But the much simpler and efficient solution is just to declare the
> metavariable with the type you want, ie
>
> volatile int V_1;

Would you like to compare software run time characteristics any more
(also according to the data type determination of expressions)?

Regards,
Markus
