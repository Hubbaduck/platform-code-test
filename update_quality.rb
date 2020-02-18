require 'award'

def update_blue_star_quality(award)
  # Blue star loses quality twice as fast as a normal award
  # Quality is therefore reduced by 2 before the expiration date
  # Quality is therefore reduced by 4 after the expiration date
  if award.expires_in > 0
    award.quality -= 2
  else
    award.quality -= 4
  end

  # Decrement time to expiration
  award.expires_in -= 1

  # If quality is negative, or 0, return 0, otherwise return the positive value
  award.quality=award.quality <= 0 ? 0 :  award.quality

  award
end

def update_quality(awards)
  awards.each do |award|

    # To improve transparancy into new code, and not add to the complexity of the exisitng code base,
    # the function for the new Blue Star method was added outside the existing structure.
    return update_blue_star_quality(award) if award.name == 'Blue Star'

    if award.name != 'Blue First' && award.name != 'Blue Compare'
      if award.quality > 0
        if award.name != 'Blue Distinction Plus'
          award.quality -= 1
        end
      end
    else
      if award.quality < 50
        award.quality += 1
        if award.name == 'Blue Compare'
          if award.expires_in < 11
            if award.quality < 50
              award.quality += 1
            end
          end
          if award.expires_in < 6
            if award.quality < 50
              award.quality += 1
            end
          end
        end
      end
    end
    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end
    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          if award.quality > 0
            if award.name != 'Blue Distinction Plus'
              award.quality -= 1
            end
          end
        else
          award.quality = award.quality - award.quality
        end
      else
        if award.quality < 50
          award.quality += 1
        end
      end
    end
  end
end
