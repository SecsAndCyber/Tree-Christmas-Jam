const BustedStr = "  BUSTED!   "
const FarkleStr = "**FARKLE**  "
const DicePourSound = preload("res://assets/Sounds/Distant_DicePour.wav")
const DiceRattleSound = preload("res://assets/Sounds/Distant_DiceRattle.wav")
const LowPointsSound = preload("res://assets/Sounds/Fanfare_15_Version_02.wav")
const HighPointsSound = preload("res://assets/Sounds/Fanfare_01_Short_Version_01.wav")
const BustSound = preload("res://assets/Sounds/Attack_At_the_Blood_River_REVERB_TAIL.wav")
const FarkleSound = preload("res://assets/Sounds/Fanfare_08_Short_Version_01.wav")
const shrink_scale = Vector2(.5,.5)
const standard_scale = Vector2(1,1)

static func is_possible_setset(needle,haystack):
	# print(haystack)
	var index = 0
	var matches = 0
	var bucket = needle.size()
	for inspect in haystack:
		if inspect == needle[index]:
			index += 1
			matches += 1
		if matches >= bucket:
			return true
	return false

const score_list = [
				[[1,2,3,4,5,6], 1000],

				[[1,1,1,1,1,1], 4000],
				[[2,2,2,2,2,2], 800],
				[[3,3,3,3,3,3], 1200],
				[[4,4,4,4,4,4], 1600],
				[[5,5,5,5,5,5], 2000],
				[[6,6,6,6,6,6], 2400],
				
				[[1,1,2,2,3,3], 750],
				[[1,1,2,2,4,4], 750],
				[[1,1,2,2,5,5], 750],
				[[1,1,2,2,6,6], 750],
				[[1,1,3,3,2,2], 750],
				[[1,1,3,3,4,4], 750],
				[[1,1,3,3,5,5], 750],
				[[1,1,3,3,6,6], 750],
				[[1,1,4,4,2,2], 750],
				[[1,1,4,4,3,3], 750],
				[[1,1,4,4,5,5], 750],
				[[1,1,4,4,6,6], 750],
				[[1,1,5,5,2,2], 750],
				[[1,1,5,5,3,3], 750],
				[[1,1,5,5,4,4], 750],
				[[1,1,5,5,6,6], 750],
				[[1,1,6,6,2,2], 750],
				[[1,1,6,6,3,3], 750],
				[[1,1,6,6,4,4], 750],
				[[1,1,6,6,5,5], 750],
				[[2,2,1,1,3,3], 750],
				[[2,2,1,1,4,4], 750],
				[[2,2,1,1,5,5], 750],
				[[2,2,1,1,6,6], 750],
				[[2,2,3,3,1,1], 750],
				[[2,2,3,3,4,4], 750],
				[[2,2,3,3,5,5], 750],
				[[2,2,3,3,6,6], 750],
				[[2,2,4,4,1,1], 750],
				[[2,2,4,4,3,3], 750],
				[[2,2,4,4,5,5], 750],
				[[2,2,4,4,6,6], 750],
				[[2,2,5,5,1,1], 750],
				[[2,2,5,5,3,3], 750],
				[[2,2,5,5,4,4], 750],
				[[2,2,5,5,6,6], 750],
				[[2,2,6,6,1,1], 750],
				[[2,2,6,6,3,3], 750],
				[[2,2,6,6,4,4], 750],
				[[2,2,6,6,5,5], 750],
				[[3,3,1,1,2,2], 750],
				[[3,3,1,1,4,4], 750],
				[[3,3,1,1,5,5], 750],
				[[3,3,1,1,6,6], 750],
				[[3,3,2,2,1,1], 750],
				[[3,3,2,2,4,4], 750],
				[[3,3,2,2,5,5], 750],
				[[3,3,2,2,6,6], 750],
				[[3,3,4,4,1,1], 750],
				[[3,3,4,4,2,2], 750],
				[[3,3,4,4,5,5], 750],
				[[3,3,4,4,6,6], 750],
				[[3,3,5,5,1,1], 750],
				[[3,3,5,5,2,2], 750],
				[[3,3,5,5,4,4], 750],
				[[3,3,5,5,6,6], 750],
				[[3,3,6,6,1,1], 750],
				[[3,3,6,6,2,2], 750],
				[[3,3,6,6,4,4], 750],
				[[3,3,6,6,5,5], 750],
				[[4,4,1,1,2,2], 750],
				[[4,4,1,1,3,3], 750],
				[[4,4,1,1,5,5], 750],
				[[4,4,1,1,6,6], 750],
				[[4,4,2,2,1,1], 750],
				[[4,4,2,2,3,3], 750],
				[[4,4,2,2,5,5], 750],
				[[4,4,2,2,6,6], 750],
				[[4,4,3,3,1,1], 750],
				[[4,4,3,3,2,2], 750],
				[[4,4,3,3,5,5], 750],
				[[4,4,3,3,6,6], 750],
				[[4,4,5,5,1,1], 750],
				[[4,4,5,5,2,2], 750],
				[[4,4,5,5,3,3], 750],
				[[4,4,5,5,6,6], 750],
				[[4,4,6,6,1,1], 750],
				[[4,4,6,6,2,2], 750],
				[[4,4,6,6,3,3], 750],
				[[4,4,6,6,5,5], 750],
				[[5,5,1,1,2,2], 750],
				[[5,5,1,1,3,3], 750],
				[[5,5,1,1,4,4], 750],
				[[5,5,1,1,6,6], 750],
				[[5,5,2,2,1,1], 750],
				[[5,5,2,2,3,3], 750],
				[[5,5,2,2,4,4], 750],
				[[5,5,2,2,6,6], 750],
				[[5,5,3,3,1,1], 750],
				[[5,5,3,3,2,2], 750],
				[[5,5,3,3,4,4], 750],
				[[5,5,3,3,6,6], 750],
				[[5,5,4,4,1,1], 750],
				[[5,5,4,4,2,2], 750],
				[[5,5,4,4,3,3], 750],
				[[5,5,4,4,6,6], 750],
				[[5,5,6,6,1,1], 750],
				[[5,5,6,6,2,2], 750],
				[[5,5,6,6,3,3], 750],
				[[5,5,6,6,4,4], 750],
				[[6,6,1,1,2,2], 750],
				[[6,6,1,1,3,3], 750],
				[[6,6,1,1,4,4], 750],
				[[6,6,1,1,5,5], 750],
				[[6,6,2,2,1,1], 750],
				[[6,6,2,2,3,3], 750],
				[[6,6,2,2,4,4], 750],
				[[6,6,2,2,5,5], 750],
				[[6,6,3,3,1,1], 750],
				[[6,6,3,3,2,2], 750],
				[[6,6,3,3,4,4], 750],
				[[6,6,3,3,5,5], 750],
				[[6,6,4,4,1,1], 750],
				[[6,6,4,4,2,2], 750],
				[[6,6,4,4,3,3], 750],
				[[6,6,4,4,5,5], 750],
				[[6,6,5,5,1,1], 750],
				[[6,6,5,5,2,2], 750],
				[[6,6,5,5,3,3], 750],
				[[6,6,5,5,4,4], 750],
				
				[[1,1,1,1,1], 3000],
				[[2,2,2,2,2], 600],
				[[3,3,3,3,3], 900],
				[[4,4,4,4,4], 1200],
				[[5,5,5,5,5], 1500],
				[[6,6,6,6,6], 1800],

				[[1,1,1,1], 2000],
				[[2,2,2,2], 400],
				[[3,3,3,3], 600],
				[[4,4,4,4], 800],
				[[5,5,5,5], 1000],
				[[6,6,6,6], 1200],

				[[1,1,1], 1000],
				[[6,6,6], 600],
				[[5,5,5], 500],
				[[4,4,4], 400],
				[[3,3,3], 300],
				[[2,2,2], 200],
				[[1,], 100],
				[[5,], 50]
				]
						
static func score(_roll_list):
	var roll_list = _roll_list.duplicate()
	var _score_value = 0
	roll_list.sort()
	while roll_list:
		var sv = _score_value
		for x in score_list:
			if is_possible_setset(x[0],roll_list):
				_score_value += x[1]
				var values = roll_list.size()
				for each in x[0]:
					while roll_list.has(each):
						roll_list.remove(roll_list.find(each))
						assert( values != roll_list.size() )
					assert( values != roll_list.size() )
				break
		if sv == _score_value:
			break
	return [_score_value, roll_list]
