Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5335C433EF
	for <cocci@archiver.kernel.org>; Sun,  3 Jul 2022 10:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=h39WEiayprV1Dy1YKK5hKbzN3G9YdesklDtNy2PkA3E=;
  b=oMYgl+qj9CnTEomwbEbmBdGg9fxZHzSXbxpeyudcxSnHnBcxDQASoZFE
   Ul8FdU7vRN5ZoGQTGNMM60ulwPlZOww3JZwQH+UJCbefZIYmY6iWkBqpv
   cmI8GWz/Xlel3myExyuIhyLd4tStWBlZ84fVksgMOgQDWBUtbkiaL8Fqe
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.92,241,1650924000"; 
   d="scan'208";a="43983319"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jul 2022 12:50:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A24FEE015F; Sun,  3 Jul 2022 12:50:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9BE10E0092
	for <cocci@sympa.inria.fr>; Sun,  3 Jul 2022 12:50:38 +0200 (CEST)
IronPort-SDR: CxScR5ADbK3wcBm9oI5UEXqmYwO2UwZkCUxhmRHJCxqqrg81jgvWK3FBKeyhp5qxitT5piqAZE
 au/cKZLha6eoK5qnY16op1+uRDUF3ZAqXLBA3kiADncUBWc0qAIkAU+3IIQtjbu614Q66U4zx2
 2uEDkK4HrbUqmyzhiz1El5wulGZaw2d0usmKAmGcAxOGWlCxzjAwe7YgLsHSlw8IMlecdPBsEa
 EWinvO5CRh8ZV1kC2wXOxOUFMQCm9R/xsUaVf3p/mfFkkbEhDVnDzZQLANfo0z+OgbYMRc1i+U
 cA9GCpWtkVsL7H6Ve6cYy5sh
X-IPAS-Result: =?us-ascii?q?A0ALAAAqc8FihwMP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPAUBAQELAYIjgVcuBAtEhE6OaIF3hFWHDocciieBfAsBAwENPwECB?=
 =?us-ascii?q?AEBhHoKAoVLAh0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?AETAQEBDA0JBQgKBw4QBTYGXgZkBIFLBIF0CzQNgjUpAYNkAwMjBBkBAREmA?=
 =?us-ascii?q?Q8LGgImAgJXBgEMCAEBgnmCZQEDMAesW38ygQGCCAEBBoRLHywiUoFcCYERL?=
 =?us-ascii?q?AGOAXonEIFVRIEVJ4JTMD6BD4NOgz2CZZouJgQPAxotLxKBH24BCAQDAwcKB?=
 =?us-ascii?q?TAGAgwYFAQCExJTHAISBQcKGw4UHCQXDA8DEgMRAQcCCRIIFSsIAwIDCAMCA?=
 =?us-ascii?q?yALAgMWCQcKAx0IChwSEBQCBBEeCwgDGR4sCQIEDgNACAsKAxEEAxMYCRYIE?=
 =?us-ascii?q?AQGAwgvDScLAwUPDQEGAwYCBQUBAyADFAMFJAcDIQ8mDQ0EGwcdAwMFJQMCA?=
 =?us-ascii?q?hsHAgIDAgYVBgICbi4NCAQIBDckDwUCBy8FBC8CHgQFBhEIAhYCBgQFAgQEF?=
 =?us-ascii?q?gIQCAIIJxcHExgbGQEFMicQCSEcCh8KBgUGFQMhbQUKOw8oNDY8LB8bCoEaL?=
 =?us-ascii?q?CsWAwQEAwIGGgMDIgIQKQYyAxUGLRUVEQYiARsCm0txliCQAJ5tNAeCFIE9g?=
 =?us-ascii?q?UQMnjIGEy2DYwGScg4GkXqWdSCnJYFiAYITMxokT4JoTgECAQINAQICAwECA?=
 =?us-ascii?q?QIJAQECjh0ZHoNuii0/NDsCBgsBAQMJhUcBAYk8AQE?=
IronPort-PHdr: A9a23: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
 dXF0q7+em4qGzP8+MwBG47LJcjBPHdzaXLU
IronPort-Data: A9a23:Y/ykHq4iAbkmF4ercGZjKwxRtBTBchMFZxGqfqrLsTDasY5as4F+v
 jQZDGCDOvqDZWqmeNp0YYiz8k8C656GxoNmGVA5+S1kZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2OaEvfDjW1nX4
 Yyq+JWGULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 OpWnoWebjUOB6TVmO4FeANENwNuNKITrdcrIVDn2SCS50jBbmeq3PhkSk07VWEa0rwuWycUr
 6NecW1LNXhvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2Wvo4Ih2xp26iiG96EN
 9U5KmZdcCjASD5FNlQNEYN9n86n0yyXnzpw8Q/J+/NuvQA/1jdZ1LHyOd7RUs6LQM9PlwCZo
 HjH9iL3GHkyP9uUwjut6WOpnuaJnCXhWYtUGqfQyxJxqFiU23BVFxAcE1e2yRWktqKgc+1EA
 FU63RgJlKEr9EazZcPhez+oqXHR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9hDoO6p5eqdsCi
 Qbhoj/5OdB8mOHEESrGrd94uRviZXJKcQfucAdZFVNt3jX1nG0kpj7iJjqJOI28lNnuAyzwz
 lhmRwBh2exI0qbnO42R9FzKhXeTDUzTUhI44w/aRG3N0++UTIuiepDu9lXRq/pNRGp4crVjl
 ChU8yR9xLlfZX1oqMBraLhddF1Oz6jdWAAweXY1Q/EcG82FohZPh7x47jBkP1tOOc0ZYzLva
 0K7kVoPucEMbCX0N/IpOtnZ5yEWIU7ISoqNuhf8MYomX3SNXFPelM2TTRPMjj62yiDAb4llY
 M3KKa5A8kr2+Yw+kWboHr5DuVPa7nlwnCvSQ4z21RKqzfKXaxaopUQtYDOzghQCxPrc+m39q
 o4BX+PTkkk3eLCgPkH/rNBCRXhXfCBTLc2n8KR/K7/TSiI4Qj1JI6GKm9sJJdc695m5Y8+To
 xlRrGcDlAGg7ZAGQC3WAk1ehETHBMol8C1gYnV0bT5FGRELOO6S0UvWTLNvFZFPyQCp5acco
 yAtd5rSD/JRZC7A/jhBP5DxoJY8Jgumj0SCMnP9MjQ4epdhQS3P+8PlJ1e+qnNRU3Dv7cZu8
 ae90g77QIYYQ1owBsjhaMWpkwG7s08blb8gREDPONRSJB7h/dEyeSz8h/M6Oe8WLhDHymfI3
 gqaG0lKuuTH5YM4qYGbiaeBpoavMu1/AksDQziFt+nrb3GC8zP6k4FaUeuOcTTMb0/O+f2vN
 bdP0vXxEPwbh1IU4YByJLZcy/5s7dXYobIHnB9vG2/GbgjwB75tfiuG0M1IuvEfz7NVo1LvC
 EeI58UcJriDfs/oSQZDKA0gZ+WF9PcVhjiLsaVrehqnvncv8erVS1hWMjmNlDdZcul/PrQl9
 uF96sQY3Aqy10gxOdGcgyEIrGmBci4aX6M8us1ICYPnkFNymFRFfICaFSL8pp2CMo0ePk4vK
 z6SpazDm7UFmhucKSVuTyCV0LoPn4kKtTBL0EQGeQaDlO3FsflrjhdfxjI6E1ZOxRJd3uMvY
 WVmOiWZ/0lVE+uEWSSCY4ytJ+2FLBie51C31FYD0mHUJ6VtuqohM0VlUdthPmhAm46fQtSf1
 K6VwiDpXF4GuenvizAqVxcNR+PLFLRMG86rpCxjN9uIFd82bFIJR0NoiXUg83PaPC/6uKELS
 SSGMgq9hW0X+BP8e5EGNrQ=
IronPort-HdrOrdr: A9a23:IIZOAKog18oPkfrGswdRHVYaV5oPeYIsimQD101hICG9vPbo8v
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/DDKysGVbfy19QYXceiGUdAb0+9BYDzrb3Gfz2R9b6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,241,1650924000"; 
   d="scan'208";a="43983315"
X-MGA-submission: =?us-ascii?q?MDHgAtBSnxTIaCAnsDpcg/B8UdFlMa5WqJPmjt?=
 =?us-ascii?q?RKMKLgrolgZI22Ytog1iFdHBNDmiOYitVvfUwjN/tvMkq+6J26RJtkWu?=
 =?us-ascii?q?+o5NlHFQe5ooHnva1h2tyCfuylNVG1QE+7EdCUg3RBw9ewmEjvKNxb4L?=
 =?us-ascii?q?uq/0wXtGRNAKk8wN3D7XQf3A=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 12:50:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656845435;
	bh=h39WEiayprV1Dy1YKK5hKbzN3G9YdesklDtNy2PkA3E=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Rv+igJW3lW69IsbHvC/JmhAqPRNLkF3r5xlvzd/c9s4ntY03oOh5ll9r2+shVy0RL
	 PIjx6i3g/T5ihPaBBu6qV+msCDghYAC6BNVgQUDwsCbTLu/92OhLcWcLXfBTOj2Xqw
	 L7Jah07uP50mVGyqL5tH3KmWgn/gSTnPe4yWAHn8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.135.75.166]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFs1z-1oOgQG2TvD-00HVxX; Sun, 03
 Jul 2022 12:50:35 +0200
Message-ID: <4d7fb336-bac9-1d94-da7c-d443a53e8b89@web.de>
Date: Sun, 3 Jul 2022 12:50:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr
Cc: Julia Lawall <julia.lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Wdh+Kss3oDIb4cTUGVBEKptxBJ1IiwfO0cms5d0IGvl+tiOMa1a
 K/d50fiRBkGs+CPFhOWQqvnxC37RLW9fpniY8dQXJzsGjc2m8jRkf5KVLZle0dvfhRv4DXD
 mBubRszuRq/hAXTHOnrU87bUwTMen1OyfBMRcITXyY1KHfNdlDt8a4pQun2Xhzu7AWW57Yw
 ehsAwMM1Oc8g7kGH9/KVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uefrNHyJy8Y=:ZwQEeWpYaP4/rKxLLMecQr
 Jv0P5a4xTXo7tnLeWyXNBMSDuU21H3E0DNEhYUykBgYacb0/ijOiVaZZkhYZeCpwah1Km3yTP
 ezLbIsNzM0wiOFW7QKbWcxBe78kwzX63W8r35p3T2KpDDWhoJ/ixAjQZVl6yxJOL2cIYvDdQJ
 n2MRmlcwF0ZoNWO9Bpge7S452zy2AnGFMKukvqPtsOfjmRFvwY//5ufiV/WZ0gVIHYiG54n8F
 MieXJz2tS8Q3afJ6Y5GThMf7Om4Yzck1K8F8u4RCNccS35zH4pAbMvV5xC79UJXPbghOWNsH8
 fUmSIRHEhSmjspJftIIdC11gQNEA6IqFdh0H6ZCHFl33exEkG6li6yPl+2R7HNDdWu9xkj2k4
 dCYnAWZ7SRi3a/DDurK7BiwIyHH+pJKoLW4uhZb3TxSNINAi3+Z/oLlX3n0GQNo6yqIaB+6UU
 3sGULvxuvQfHqPDBzKeRpyK7mGbOhq9d3z5RY43/U4zJXxhuamOaQQq1Nkh21N7I/RLcOqJXP
 UgB4lc5GUV0+Hjldfm6/Ij7PNXYdIRPHcd9WAMfLScmV9PbMOHMpmjMPwQ85G+Vzm4lVi7Y8X
 P9W7p+tb2je8QZq+k8XD/D3VXrpd/alRP8xde5RPI89vA38wHYhWzxsfUtRKPZ+s28cJ6DAax
 bNv1JHOBtk6doV0vBcGW8gIBU7ffJyf2OihJ/pIXw2QDudxJ4OTnAZDwZIoSP2aRpJ3AzvKOj
 1JWcJMXCzyNf0sQgeQ5YDFE+3/RWtrAJpPdNk5Hu3gtJFi6Ju0hqBKXQP0SKd1kXoq67KgGJC
 AeIOfUDmev11mYCuA3kXdaoAPgUxYRmx6yzaU4tDm46J0atOJ5pN2tqi/1ooXQFy+8nVTbQM1
 6ZiyGziCGD8o33shTCpkeRkLSm7usill6Ya0yR8XcomM2A7THxkMjX6/CDRj5xNPNYooV1WDg
 D9MsGLYijwB9LS/62J85uvVIlUuehzCiriiVcvMRsWT8a/l9AowmiSNutLew7IH3IXqaaNeOg
 +3NwZSQx8oEdfadzjas89rAOqri9Z9l+WXwNBFN+oK6ViGNt48g5FA1w7/yMWJ9iE1VdXjYHH
 DL6amJRkoZ0aap/820dYSwRdEZ8OD87CdiVCfF/eLdrJjzzbMpTQffAwQ==
Subject: Re: [cocci] [PATCH v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 479
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/4d7fb336-bac9-1d94-da7c-d443a53e8b89%40web.de>

> ---
> v4 -> v5: Change semantic patch to match explicit tests to NULL +
> improve commit message


I find it sufficient to specify the version list without arrows.
Would you like to avoid the repetition of version numbers in the change log?

Regards,
Markus

