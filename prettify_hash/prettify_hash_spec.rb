require 'rails_helper'

describe PrettifyHash do
  subject { described_class.call(input) }

  context 'single line hash' do
    let(:input) do
      { a_hash_key: 'first value', b_hash_key: 'second value', c_hash_key: 333 }
    end

    let(:expected_output) do
      %({ a_hash_key: 'first value', b_hash_key: 'second value', c_hash_key: 333 })
    end

    it { is_expected.to eql(expected_output) }
  end

  context 'single line hash, but force first line to wrap' do
    subject { described_class.call(input, force_wrap: true) }

    let(:input) do
      { a_hash_key: 'first value', b_hash_key: 'second value', c_hash_key: 333 }
    end

    let(:expected_output) do
      <<~TXT.strip
        {
          a_hash_key: 'first value',
          b_hash_key: 'second value',
          c_hash_key: 333
        }
      TXT
    end

    it { is_expected.to eql(expected_output) }

    context 'indents 1 unit' do
      subject { described_class.call(input, indent: 1, force_wrap: true) }

      let(:expected_output) do
        %(  {\n) +
        %(    a_hash_key: 'first value',\n) +
        %(    b_hash_key: 'second value',\n) +
        %(    c_hash_key: 333\n) +
        %(  })
      end

      it { is_expected.to eql(expected_output) }
    end

    context 'indents 2 units' do
      subject { described_class.call(input, indent: 2, force_wrap: true) }

      let(:expected_output) do
        %(    {\n) +
        %(      a_hash_key: 'first value',\n) +
        %(      b_hash_key: 'second value',\n) +
        %(      c_hash_key: 333\n) +
        %(    })
      end

      it { is_expected.to eql(expected_output) }
    end
  end

  context 'will automatically wrap when single line exceeds 120 characters' do
    subject { described_class.call(input) }

    let(:input) do
      {
        a_hash_key: 'first value',
        b_hash_key: 'second value',
        c_hash_key: 333,
        d_hash_key: 4_444_555,
        e_hash_key: 'this is a really really really long string',
        f_hash_key: 'this is another really really long string'
      }
    end

    let(:expected_output) do
      <<~TXT.strip
        {
          a_hash_key: 'first value',
          b_hash_key: 'second value',
          c_hash_key: 333,
          d_hash_key: 4444555,
          e_hash_key: 'this is a really really really long string',
          f_hash_key: 'this is another really really long string'
        }
      TXT
    end

    it { is_expected.to eql(expected_output) }

    context 'with 1 level of nesting' do
      let(:input) do
        {
          a_hash_key: 'first value',
          b_hash_key: 'second value',
          c_hash_key: 333,
          d_hash_key: 4_444_555,
          e_hash_key: 'this is a really really really long string',
          f_hash_key: 'this is another really really long string',
          g_hash_key: {
            nested_hash_key_1: 'this',
            nested_hash_key_2: 'is',
            nested_hash_key_3: 'going',
            nested_hash_key_4: 'to',
            nested_hash_key_5: 'have',
            nested_hash_key_6: 'lots',
            nested_hash_key_7: 'of',
            nested_hash_key_8: 'wrap'
          },
          h_hash_key: { nowrap: "this won't wrap" }
        }
      end

      let(:expected_output) do
        <<~TXT.strip
          {
            a_hash_key: 'first value',
            b_hash_key: 'second value',
            c_hash_key: 333,
            d_hash_key: 4444555,
            e_hash_key: 'this is a really really really long string',
            f_hash_key: 'this is another really really long string',
            g_hash_key: {
              nested_hash_key_1: 'this',
              nested_hash_key_2: 'is',
              nested_hash_key_3: 'going',
              nested_hash_key_4: 'to',
              nested_hash_key_5: 'have',
              nested_hash_key_6: 'lots',
              nested_hash_key_7: 'of',
              nested_hash_key_8: 'wrap'
            },
            h_hash_key: { nowrap: "this won't wrap" }
          }
        TXT
      end

      it { is_expected.to eql(expected_output) }

      context 'with nested value is < 120 chars, but exceeds with indent' do
        let(:input) do
          {
            a_hash_key: 'first value',
            b_hash_key: 'second value',
            long_hash_key: { n_hash_key_1: 'this', n_hash_key_2: 'text', nested_hash_key_2: 'should', nested_hash_key_3: 'wrap..' },
            h_hash_key: { nowrap: "this won't wrap because the total string length including indent is equal to 120 characters." }
          }
        end

        let(:expected_output) do
          <<~TXT.strip
          {
            a_hash_key: 'first value',
            b_hash_key: 'second value',
            long_hash_key: {
              n_hash_key_1: 'this',
              n_hash_key_2: 'text',
              nested_hash_key_2: 'should',
              nested_hash_key_3: 'wrap..'
            },
            h_hash_key: { nowrap: "this won't wrap because the total string length including indent is equal to 120 characters." }
          }
          TXT
        end

        it { is_expected.to eql(expected_output) }
      end
    end

    context 'with 2 levels of nesting' do
      let(:input) do
        {
          a_hash_key: 'first value',
          b_hash_key: 'second value',
          c_hash_key: 333,
          d_hash_key: 4_444_555,
          e_hash_key: 'this is a really really really long string',
          f_hash_key: 'this is another really really long string',
          g_hash_key: {
            nested_hash_key_1: 'this',
            nested_hash_key_2: 'is',
            nested_hash_key_3: 'going',
            nested_hash_key_4: 'to',
            nested_hash_key_5: 'have',
            nested_hash_key_6: 'lots',
            nested_hash_key_7: 'of',
            nested_hash_key_8: 'wrap',
            nested_hash_key_really_long: {
              nested2_key_1: 'this',
              nested2_key_2: 'is',
              nested2_key_3: 'another',
              nested2_key_4: 'long',
              nested2_key_5: 'nested',
              nested2_key_6: 'hash',
            },
            array_hash_key_oneline: [
              { array_hash_key_1: 'just numbers', array_hash_key_2: 3456 },
              'this is a string value',
            ],
            array_hash_key_multiline: [
              { array_hash_key_1: 'this one has a long string', array_hash_key_2: 555555 },
              "it's going to be an array going multiple lines",
              6545645
            ]
          },
          h_hash_key: { nowrap: "this won't wrap" }
        }
      end

      let(:expected_output) do
        <<~TXT.strip
          {
            a_hash_key: 'first value',
            b_hash_key: 'second value',
            c_hash_key: 333,
            d_hash_key: 4444555,
            e_hash_key: 'this is a really really really long string',
            f_hash_key: 'this is another really really long string',
            g_hash_key: {
              nested_hash_key_1: 'this',
              nested_hash_key_2: 'is',
              nested_hash_key_3: 'going',
              nested_hash_key_4: 'to',
              nested_hash_key_5: 'have',
              nested_hash_key_6: 'lots',
              nested_hash_key_7: 'of',
              nested_hash_key_8: 'wrap',
              nested_hash_key_really_long: {
                nested2_key_1: 'this',
                nested2_key_2: 'is',
                nested2_key_3: 'another',
                nested2_key_4: 'long',
                nested2_key_5: 'nested',
                nested2_key_6: 'hash'
              },
              array_hash_key_oneline: [{ array_hash_key_1: 'just numbers', array_hash_key_2: 3456 }, 'this is a string value'],
              array_hash_key_multiline: [
                { array_hash_key_1: 'this one has a long string', array_hash_key_2: 555555 },
                "it's going to be an array going multiple lines",
                6545645
              ]
            },
            h_hash_key: { nowrap: "this won't wrap" }
          }
        TXT
      end

      it { is_expected.to eql(expected_output) }
    end
  end

  context '1 level nesting' do
    let(:input) do
      {
        car: { material_cost: 1.0, labor_cost: 2.0, profit_cost: 3.0 },
        truck: { material_cost: 1.0, labor_cost: 2.0, profit_cost: 3.0 },
        suv: { material_cost: 1.0, labor_cost: 2.0, profit_cost: 3.0 }
      }
    end

    let(:expected_output) do
      <<~TXT.strip
        {
          car: { material_cost: 1.0, labor_cost: 2.0, profit_cost: 3.0 },
          truck: { material_cost: 1.0, labor_cost: 2.0, profit_cost: 3.0 },
          suv: { material_cost: 1.0, labor_cost: 2.0, profit_cost: 3.0 }
        }
      TXT
    end

    it { is_expected.to eql(expected_output) }
  end

  context 'multiple levels nesting' do
    let(:input) do
      {
        car: {
          material_cost: 1.0, labor_cost: 2.0, profit_cost: 3.0, special_cost: 4.0, additional_cost: 5.0,
          nested_cost: {
            nested_level_2: true,
            property_detail_level_2: BigDecimal('12345.6789'),
            long_text_property: 'this is a text string that should wrap onto a new line'
          },
          utility_cost: 6.0,
          compliance_cost: 7.0
        },
        truck: { material_cost: 1.0, labor_cost: 2.0, profit_cost: 3.0 },
        suv: { material_cost: 1.0, labor_cost: 2.0, profit_cost: 3.0 }
      }
    end

    let(:expected_output) do
      <<~TXT.strip
        {
          car: {
            material_cost: 1.0,
            labor_cost: 2.0,
            profit_cost: 3.0,
            special_cost: 4.0,
            additional_cost: 5.0,
            nested_cost: {
              nested_level_2: true,
              property_detail_level_2: 12345.6789.to_d,
              long_text_property: 'this is a text string that should wrap onto a new line'
            },
            utility_cost: 6.0,
            compliance_cost: 7.0
          },
          truck: { material_cost: 1.0, labor_cost: 2.0, profit_cost: 3.0 },
          suv: { material_cost: 1.0, labor_cost: 2.0, profit_cost: 3.0 }
        }
      TXT
    end

    it { is_expected.to eql(expected_output) }
  end
end
