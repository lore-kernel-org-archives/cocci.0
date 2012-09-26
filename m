From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Wed, 26 Sep 2012 18:06:49 +0200
Subject: [Cocci] Help with SMPL
In-Reply-To: <506326D7.4040802@metafoo.de>
References: <CA+MoWDrEmG1NowmRpB3S_4MnnxOk1q9=fo-tkCmL3PLrgn5K0w@mail.gmail.com>
 <50631EE2.4030208@metafoo.de>
 <CALF0-+WC8EG861-szF3yQQEpawvv8QS4j7qZTqZGKy08-8=Ekg@mail.gmail.com>
 <506326D7.4040802@metafoo.de>
Message-ID: <CA+MoWDrSU4AW55oB=s_GRthipVsBLMNGmOTFKKWSLxmgKorMTQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I suppose these should not be auto-converted since there is clearly a bug
> somewhere. The following cocci patch can be used to find locations where
> memcpy is used and the types of "to" and "from" do not match, but the size
> parameter is sizeof one of them.

Yes, I wanted to generate an index of possible candidates for manual
checking. Thanks for the second patch.


-- 
Peter
