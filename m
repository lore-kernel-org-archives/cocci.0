From: mstefani@redhat.com (Michael Stefaniuc)
Date: Tue, 31 Jan 2017 11:13:23 +0100
Subject: [Cocci] some questions related to output formatting
In-Reply-To: <alpine.DEB.2.20.1701261637330.3109@hadrien>
References: <FAB49815-C2ED-4463-94A6-A766A21C6F9B@linaro.org>
 <alpine.DEB.2.20.1701261516370.3109@hadrien>
 <EC57B573-1942-4118-A86D-9177BA76DFE3@linaro.org>
 <alpine.DEB.2.20.1701261637330.3109@hadrien>
Message-ID: <95fee34e-cafd-45f6-4e8f-073d873c600a@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 01/26/2017 04:37 PM, Julia Lawall wrote:
> 
> 
> On Thu, 26 Jan 2017, Kumar Gala wrote:
> 
>>
>>> On Jan 26, 2017, at 8:18 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>>
>>>
>>>
>>> On Thu, 26 Jan 2017, Kumar Gala wrote:
>>>
>>>> 1. Is there a way to adjust the 80 char line break limit?
>>>
>>> Currently, it's a non-modifiable configuration variable.  I can add a flag
>>> for it.
>>
>> That would be useful.
> 
> You can pull this from github.  --max-width n
Thanks Julia!
This is helpful for my Wine work where the preferred line length is 100.
I just kept forgetting to ask for it.

bye
	michael
