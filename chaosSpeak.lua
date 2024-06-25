local EventFrame = CreateFrame("frame", "EventFrame")
EventFrame:RegisterEvent("ADDON_LOADED")



defaultValues = {
chaosTxt = "rude"
}

screwYou = "WHAT"






function generateRandomSentence()
    local sentenceParts = {}

    -- Generate a random number of sentences to stitch together (between 2 and 4)
    local numParts = math.random(2, 4)

    for i = 1, numParts do
        local randomSentence = sentences[math.random(1, #sentences)]
        table.insert(sentenceParts, randomSentence)
    end

    -- Insert random vocabulary items into sentence parts
    for i, part in ipairs(sentenceParts) do
        local replacedPart = part:gsub("%a+", function(match)
            if math.random() < 0.5 then
                local randomIndex = math.random(1, #vocabulary)
                return vocabulary[randomIndex]
            else
                return match
            end
        end)
        sentenceParts[i] = replacedPart
    end

    -- Concatenate sentence parts into a single sentence
    local finalSentence = table.concat(sentenceParts, " ")
    return finalSentence
end




--Add Chaos Speak to Treant Speak (if it's available)
EventFrame:SetScript("OnEvent", function(self, event, arg1, ...)
	if(event == "ADDON_LOADED") then
		if(arg1=='Treant_Speak') then
			addNewLanguage('CHAOS', {buffRequirements=nil, isRealLanguage=true, translationFunction=chaosLand, translationTable=nil})
		elseif arg1=="Chaos_Speak" then
			doStuffWithSavedVariables()
		end
	end
end)



function chaosLand(message)
	return string.sub(generateRandomSentence(), 1, 200)
	--Ensure our string is within 200 characters so it can be shown
end



