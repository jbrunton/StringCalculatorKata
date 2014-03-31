require 'calculator'

describe Calculator do
  
  it 'returns zero when given an empty string' do
    expect(subject.add("")).to eq(0)
  end
  
  it 'returns the sum of a list with one number' do
    expect(subject.add("1")).to eq(1)
    expect(subject.add("2")).to eq(2)
  end
  
  it 'returns the sum of a list with two numbers' do
    expect(subject.add("1,2")).to eq(3)
  end
  
  it 'returns the sum of a list of numbers' do 
    expect(subject.add("1,2,3")).to eq(6)
  end
  
  it 'returns the sum of a list of numbers separated by commas and new lines' do
    expect(subject.add("1\n2,3")).to eq(6)
  end
  
  it 'returns the sum of a list with specified delimiter' do
    expect(subject.add("//;\n1;2")).to eq(3)
    expect(subject.add("//;\n2;3")).to eq(5)
  end
  
  it 'allows delimiters greater than one character' do
    expect(subject.add("//***\n1***2***3")).to eq(6)
  end
  
  it 'allows multiple delimiters to be specified' do
    expect(subject.add("//[*][%]\n1*2%3")).to eq(6)
  end

  it 'disallows negative numbers' do
    expect{ subject.add("-1") }.to raise_error("Negatives not allowed: -1")
    expect{ subject.add("-1,3,-2") }.to raise_error("Negatives not allowed: -1, -2")
  end
  
  it 'ignores numbers greater than 1000' do
    expect(subject.add("2, 1001")).to eq(2)
  end
  
  context "#prepare_array" do
    it 'splits the array by the specified delimeters' do
      expect(subject.prepare_array("//;\n1;2")).to eq([1,2])
    end
  end
end
