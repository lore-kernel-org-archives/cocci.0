From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Wed, 26 Sep 2012 13:02:53 -0300
Subject: [Cocci] Help with SMPL
In-Reply-To: <506326D7.4040802@metafoo.de>
References: <CA+MoWDrEmG1NowmRpB3S_4MnnxOk1q9=fo-tkCmL3PLrgn5K0w@mail.gmail.com>
 <50631EE2.4030208@metafoo.de>
 <CALF0-+WC8EG861-szF3yQQEpawvv8QS4j7qZTqZGKy08-8=Ekg@mail.gmail.com>
 <506326D7.4040802@metafoo.de>
Message-ID: <CALF0-+W50QX3jtxT1PHoUkFwC4Ybdwr3LmAToEuR5pU9qV-8Hw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Sep 26, 2012 at 1:01 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 09/26/2012 05:40 PM, Ezequiel Garcia wrote:
>> Hi,
>>
>> On Wed, Sep 26, 2012 at 12:27 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> On 09/26/2012 04:36 PM, Peter Senna Tschudin wrote:
>>>> Dear List,
>>>>
>>>> I'm trying to make a semantic patch for the case described on the patch:
>>>> http://www.mail-archive.com/linux-media at vger.kernel.org/msg52660.html
>>>>
>>
>> More cases like these:
>>
>> http://patchwork.linuxtv.org/patch/13100/
>>
>> This is part of a whole patchset with subject:
>>
>> media: XXX: Replace struct memcpy with struct assignment
>>
>> The type of src and dst structs should match, but in some buggy code
>> that may not be true.
>
> I suppose these should not be auto-converted since there is clearly a bug
> somewhere. The following cocci patch can be used to find locations where
> memcpy is used and the types of "to" and "from" do not match, but the size
> parameter is sizeof one of them.
>

True. This should not be auto-converted but rather be used as warning:
"Hey! you're doing some very bad things here"

Thanks,
Ezequiel.
