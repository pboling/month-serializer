RSpec.describe Month::Serializer do
  it 'has a version number' do
    expect(Month::Serializer::VERSION).not_to be nil
  end

  describe '#to_i' do
    {
      -471359 => Month.new(-39280, 1),  # hist: Extinction of Neanderthal
      -395999 => Month.new(-33000, 1),  # hist: Domestication of Dogs
      -9035 => Month.new(-753, 1),      # hist: Founding of Rome
      -24   => Month.new(-3, 12),
      -23   => Month.new(-2, 1),
      -12   => Month.new(-2, 12),
      -11   => Month.new(-1, 1),
      -6    => Month.new(-1, 6),
      -3    => Month.new(-1, 9),
      -1    => Month.new(-1, 11),
      0     => Month.new(-1, 12),
      1     => Month.new(0, 1),         # hist:Kingdom of Aksum Founded
      7     => Month.new(0, 7),
      11    => Month.new(0, 11),
      12    => Month.new(0, 12),        # hist: Ovid writes Metamorphoses
      13    => Month.new(1, 1),
      23    => Month.new(1, 11),
      24    => Month.new(1, 12),
      25    => Month.new(2, 1),
      15489 => Month.new(1290, 9),      # ref: Lord of the Rings (2001)
      23830 => Month.new(1985, 10),     # ref: Watchmen (2009)
      23831 => Month.new(1985, 11),     # ref: Back to the Future (1985)
      23918 => Month.new(1993, 2),      # ref: Groundhog Day (1993)
      23959 => Month.new(1996, 7),      # ref: Independence Day (1996)
      23972 => Month.new(1997, 8),      # ref: Terminator II: Judgement Day ()
      23974 => Month.new(1997, 10),     # ref: Lost in Space (1965-1968)
      24001 => Month.new(2000, 1),      # ref: Futurama (1999-2013)
      24057 => Month.new(2004, 9),      # ref: Lost (1999-2013)
      24194 => Month.new(2016, 2),      # ref: Ghostbusters II (1989)
      24201 => Month.new(2016, 9),
      24202 => Month.new(2016, 10),
      24203 => Month.new(2016, 11),
      24204 => Month.new(2016, 12),
      24205 => Month.new(2017, 1),
      24206 => Month.new(2017, 2),
      24207 => Month.new(2017, 3),
      24208 => Month.new(2017, 4),
      24209 => Month.new(2017, 5),
      24210 => Month.new(2017, 6),
      24211 => Month.new(2017, 7),
      24212 => Month.new(2017, 8),
      24213 => Month.new(2017, 9),
      24214 => Month.new(2017, 10),
      24215 => Month.new(2017, 11),
      24216 => Month.new(2017, 12),
      24217 => Month.new(2018, 1),
      24218 => Month.new(2018, 2),
      24219 => Month.new(2018, 3),
      24220 => Month.new(2018, 4),
      24221 => Month.new(2018, 5),
      24222 => Month.new(2018, 6),
      24223 => Month.new(2018, 7),
      24224 => Month.new(2018, 8),
      24225 => Month.new(2018, 9),
      24226 => Month.new(2018, 10),
      24227 => Month.new(2018, 11),
      24228 => Month.new(2018, 12),
      24760 => Month.new(2063, 4),      # Star Trek: First Contact (1996)
    }.each do |k, v|
      context "#{v}" do
        it "is #{k}" do
          expect(v.to_i).to eq(k)
        end
        it "can load #{k} to #{v}" do
          expect(Month.load(k)).to eq(v)
        end
        it "can dump #{v} to #{k}" do
          expect(Month.dump(v)).to eq(k)
        end
        context 'round trip' do
          it "converts back to #{v}" do
            expect((Month.load(Month.dump(v)))).to eq(v)
          end
        end
      end
    end
  end

  describe '#to_date' do
    {
        -471359 => Date.new(-39280, 1, 1),  # hist: Extinction of Neanderthal
        -395999 => Date.new(-33000, 1, 1),  # hist: Domestication of Dogs
        -9035 => Date.new(-753, 1, 1),      # hist: Founding of Rome
        -24   => Date.new(-3, 12, 1),
        -23   => Date.new(-2, 1, 1),
        -12   => Date.new(-2, 12, 1),
        -11   => Date.new(-1, 1, 1),
        -6    => Date.new(-1, 6, 1),
        -3    => Date.new(-1, 9, 1),
        -1    => Date.new(-1, 11, 1),
        0     => Date.new(-1, 12, 1),
        1     => Date.new(0, 1, 1),         # hist:Kingdom of Aksum Founded
        7     => Date.new(0, 7, 1),
        11    => Date.new(0, 11, 1),
        12    => Date.new(0, 12, 1),        # hist: Ovid writes Metamorphoses
        13    => Date.new(1, 1, 1),
        23    => Date.new(1, 11, 1),
        24    => Date.new(1, 12, 1),
        25    => Date.new(2, 1, 1),
        15489 => Date.new(1290, 9, 1),      # ref: Lord of the Rings (2001)
        23830 => Date.new(1985, 10, 1),     # ref: Watchmen (2009)
        23831 => Date.new(1985, 11, 1),     # ref: Back to the Future (1985)
        23918 => Date.new(1993, 2, 1),      # ref: Groundhog Day (1993)
        23959 => Date.new(1996, 7, 1),      # ref: Independence Day (1996)
        23972 => Date.new(1997, 8, 1),      # ref: Terminator II: Judgement Day ()
        23974 => Date.new(1997, 10, 1),     # ref: Lost in Space (1965-1968)
        24001 => Date.new(2000, 1, 1),      # ref: Futurama (1999-2013)
        24057 => Date.new(2004, 9, 1),      # ref: Lost (1999-2013)
        24194 => Date.new(2016, 2, 1),      # ref: Ghostbusters II (1989)
        24201 => Date.new(2016, 9, 1),
        24202 => Date.new(2016, 10, 1),
        24203 => Date.new(2016, 11, 1),
        24204 => Date.new(2016, 12, 1),
        24205 => Date.new(2017, 1, 1),
        24206 => Date.new(2017, 2, 1),
        24207 => Date.new(2017, 3, 1),
        24208 => Date.new(2017, 4, 1),
        24209 => Date.new(2017, 5, 1),
        24210 => Date.new(2017, 6, 1),
        24211 => Date.new(2017, 7, 1),
        24212 => Date.new(2017, 8, 1),
        24213 => Date.new(2017, 9, 1),
        24214 => Date.new(2017, 10, 1),
        24215 => Date.new(2017, 11, 1),
        24216 => Date.new(2017, 12, 1),
        24217 => Date.new(2018, 1, 1),
        24218 => Date.new(2018, 2, 1),
        24219 => Date.new(2018, 3, 1),
        24220 => Date.new(2018, 4, 1),
        24221 => Date.new(2018, 5, 1),
        24222 => Date.new(2018, 6, 1),
        24223 => Date.new(2018, 7, 1),
        24224 => Date.new(2018, 8, 1),
        24225 => Date.new(2018, 9, 1),
        24226 => Date.new(2018, 10, 1),
        24227 => Date.new(2018, 11, 1),
        24228 => Date.new(2018, 12, 1),
        24760 => Date.new(2063, 4, 1),      # Star Trek: First Contact (1996)
    }.each do |k, v|
      context "#{k} => #{v}" do
        it "converts" do
          expect(Month.load(k).to_date).to eq(v)
        end
      end
    end
  end

  describe '.dump' do
    subject { Month.dump(month) }
    context 'December, 2017' do
      let(:integer) { 24216 }
      let(:month) { Month.new(2017, 12) }
      subject { Month.dump(month) }
      it 'serializes to Integer' do
        is_expected.to be_a(Integer)
      end
      it 'is integer' do
        is_expected.to eq(integer)
      end
    end
    context 'January, 2018' do
      let(:integer) { 24217 }
      let(:month) { Month.new(2018, 1) }
      it 'serializes to Integer' do
        is_expected.to be_a(Integer)
      end
      it 'is integer' do
        is_expected.to eq(integer)
      end
    end
    context 'November, 2018' do
      let(:integer) { 24227 }
      let(:month) { Month.new(2018, 11) }
      it 'serializes to Integer' do
        is_expected.to be_a(Integer)
      end
      it 'is integer' do
        is_expected.to eq(integer)
      end
    end
    context 'December, 2018' do
      let(:integer) { 24228 }
      let(:month) { Month.new(2018, 12) }
      it 'serializes to Integer' do
        is_expected.to be_a(Integer)
      end
      it 'is integer' do
        is_expected.to eq(integer)
      end
    end
  end

  describe '.load' do
    context 'December, 2017' do
      let(:integer) { 24216 }
      subject { Month.load(integer) }
      it 'serializes from Integer' do
        is_expected.to be_a(Month)
      end
      context 'sets number' do
        subject { Month.load(integer).number }
        it 'is 11' do
          is_expected.to eq(12)
        end
      end
      context 'sets month' do
        subject { Month.load(integer).year }
        it 'is 2018' do
          is_expected.to eq(2017)
        end
      end
    end
    context 'January, 2018' do
      let(:integer) { 24217 }
      subject { Month.load(integer) }
      it 'serializes from Integer' do
        is_expected.to be_a(Month)
      end
      context 'sets number' do
        subject { Month.load(integer).number }
        it 'is 1' do
          is_expected.to eq(1)
        end
      end
      context 'sets month' do
        subject { Month.load(integer).year }
        it 'is 2018' do
          is_expected.to eq(2018)
        end
      end
    end
    context 'November, 2018' do
      let(:integer) { 24227 }
      subject { Month.load(integer) }
      it 'serializes from Integer' do
        is_expected.to be_a(Month)
      end
      context 'sets number' do
        subject { Month.load(integer).number }
        it 'is 11' do
          is_expected.to eq(11)
        end
      end
      context 'sets month' do
        subject { Month.load(integer).year }
        it 'is 2018' do
          is_expected.to eq(2018)
        end
      end
    end
    context 'December, 2018' do
      let(:integer) { 24228 }
      subject { Month.load(integer) }
      it 'serializes from Integer' do
        is_expected.to be_a(Month)
      end
      context 'sets number' do
        subject { Month.load(integer).number }
        it 'is 12' do
          is_expected.to eq(12)
        end
      end
      context 'sets month' do
        subject { Month.load(integer).year }
        it 'is 2018' do
          is_expected.to eq(2018)
        end
      end
    end
  end
end
